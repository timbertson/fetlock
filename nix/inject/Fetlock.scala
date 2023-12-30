package net.gfxmonk.fetlock.derive

import coursier._
import coursier.cache.ArtifactError
import coursier.cache.{FileCache, Cache, CacheDefaults}
import coursier.core.{Authentication, Publication, Attributes, Reconciliation}
import coursier.credentials.Credentials
import coursier.util.{Artifact, Task => CsrTask, EitherT, ModuleMatchers}
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.io.PrintWriter
import java.net.URI
import java.nio.charset.StandardCharsets
import java.nio.file.{Path, Paths, Files}
import java.util.concurrent.ConcurrentHashMap
import sbt.librarymanagement.ivy.{Credentials => IvyCredentials}
import sbt.{ModuleID, TaskKey, Task, Keys, Setting, Def}
import scala.annotation.nowarn
import scala.collection.mutable
import scala.concurrent.ExecutionContext
import scala.jdk.CollectionConverters._
import scala.util.Properties
import scala.util.{Try, Failure}

object DeriveDep extends sbt.AutoPlugin {
	object Internal {
		implicit val ec: ExecutionContext = ExecutionContext.global

		class JsonScope(val delimiters: Delimiters, var empty: Boolean = true)

		case class Delimiters(openStr: String, closeStr: String)
		object Delimiters {
			val obj = Delimiters("{", "}")
			val arr = Delimiters("[", "]")
		}

		class JsonWriter(outStream: OutputStream, closeFn: () => Unit) {
			private val out = new PrintWriter(outStream)
			private var scopes = mutable.Queue.empty[JsonScope]
			private def push(d: Delimiters) = {
				indent()
				out.print(d.openStr)
				scopes.enqueue(new JsonScope(d))
			}

			def pushObj(block: => Unit) = {
				push(Delimiters.obj)
				block
				pop()
			}

			def pushArray(block: => Unit) = {
				push(Delimiters.arr)
				block
				pop()
			}
			
			def key(k: String) = {
				str(k)
				out.print(": ")
			}

			def nul() = {
				// TODO escape
				out.print("null")
			}

			def bool(b: Boolean) = {
				out.print(if (b) "true" else "false")
			}
			
			def str(s: String) = {
				// TODO escape
				out.print('"')
				out.print(s.replaceAll("\n", "\\\\n"))
				out.print('"')
			}
			
			private def indent() = {
				out.print('\n')
				out.print("  " * scopes.size)
			}

			def startElem() = {
				for (last <- scopes.lastOption) {
					if (!last.empty) {
						indent()
						out.print(", ")
					} else {
						out.print(" ")
					}
					scopes.last.empty = false
				}
			}

			private def pop() = scopes.lastOption match {
				case None => ???
				case Some(last) => {
					scopes = scopes.init
					indent()
					out.print(last.delimiters.closeStr)
				}
			}
			
			def close() = {
				out.flush()
				closeFn()
			}
		}
		object JsonWriter {
			def apply() = {
				val args = sys.env.get("FETLOCK_OUTPUT")
					.map(path => {
						new FileOutputStream(path)
					})
					.map(stream => (stream, () => stream.close()))
					.getOrElse((scala.Console.out, () => ()))
				new JsonWriter(args._1, args._2)
			}
		}
	}

	object autoImport {
		val fetlockGenerate: TaskKey[Unit] = sbt.taskKey("output generated for fetlock to use")
	}

	import autoImport._
	import Internal._

	override def trigger = allRequirements
	override def requires: sbt.Plugins = sbt.plugins.JvmPlugin

	override def globalSettings: Seq[Setting[_]] = Def.settings(
		// fetlockGenerate := run.value
		// Keys.commands ++= SubmitDependencyGraph.commands
	)

	override def projectSettings: Seq[Setting[_]] = Def.settings(
		fetlockGenerate := run.value,
		// Keys.transitiveClassifiers := Seq("pom"),

		// // reverse default exclusion of SBT
		// // (these are ignored by default as they are provided by the launcher,
		// // but we want to capture launch deps too)
		// Keys.moduleSettings := {
		// 	val base = Keys.moduleSettings.value.asInstanceOf[ModuleDescriptorConfiguration]
		// 	println(s" - base excludes: ${base.excludes}")
		// 	val filtered = base.withExcludes(base.excludes.filter(_.organization != "org.scala-sbt"))
		// 	println(s" - new excludes: ${filtered.excludes}")
		// 	// TODO why no artifacts in somen of these build deps?
		// 	filtered
		// }
		// githubDependencyManifest := manifestTask.value,
		// githubDependencyManifest / Keys.aggregate := false
	)

	private val run = Def.task {
		val scalaVersion = (Keys.artifactName / Keys.scalaVersion).value
		val scalaBinaryVersion = (Keys.artifactName / Keys.scalaBinaryVersion).value
		val crossVersion = sbt.CrossVersion.apply(scalaVersion, scalaBinaryVersion)
		val logger = Keys.streams.value.log

		def moduleIdToDepencency(includeTest: Boolean)(plainModuleId: ModuleID): Option[Dependency] = {
			val m = crossVersion(plainModuleId)
			val mattrs = m.extraAttributes ++ m.extraDependencyAttributes
			// TODO: I can't see where this happens in SBT, just that the attrs disagree between what I get
			//       and what coursier-sbt-maven-dependency expects:
			//       https://github.com/coursier/coursier/blob/1539a6a2ba4642c7cfe4699c3d8252a864d84965/modules/sbt-maven-repository/shared/src/main/scala/coursier/maven/SbtMavenRepository.scala#L85-L86

			val mappedAttrs = m.extraAttributes.map { case (k,v) => k.stripPrefix("e:") -> v }.toMap
			val dep = Dependency(
				Module(
					Organization(m.organization),
					ModuleName(m.name),
					mappedAttrs),
			m.revision)
			m.configurations match {
				case Some("test") if !includeTest => None
				case _ => Some(dep)
			}
		}

		val csrConfig = Keys.csrConfiguration.value
		// println(s"csrConfig: ${csrConfig}");
		val creds = Keys.allCredentials.value
		val repos = csrConfig.resolvers.flatMap {
			case mvn: sbt.librarymanagement.MavenRepository => {
				val host = new URI(mvn.root).getHost
				// val auth = IvyCredentials.forHost(creds, host).map { creds =>
				// 	// NOTE: we don't include user, as that may leak into the cache path
				// 	val headerB64 = java.util.Base64.getEncoder.encodeToString(
				// 		s"${creds.userName}:${creds.passwd}".getBytes(StandardCharsets.UTF_8)
				// 	)
				// 	val authHeader = ("authorization", s"Basic ${headerB64}")
					
				// 	// NOTE: coursier includes user@ in the cache path when setting credentials
				// 	// on a specific repo. To match what SBT does currently, we instead use a custom
				// 	// cache with credentials, and those don't make it into the artifact paths.
				// 	Authentication(
				// 		// user = creds.userName,
				// 		// passwordOpt = Some(creds.passwd),
				// 		httpHeaders = List(authHeader),
				// 		realmOpt = Some(creds.realm),
				// 		optional = true, // guess?
				// 		httpsOnly = true, // surely
				// 		passOnRedirect = false,
				// 	)
				// }
				Some(coursier.maven.SbtMavenRepository(mvn.root, None))
			}
			case other => {
				println(s"skipping repo ${other}")
				None
			}
		}
		
		logger.info("Resolving dependencies using coursier ...")

		val csrCacheRootFile = CacheDefaults.location
		val csrCacheRoot = Paths.get(csrCacheRootFile.getPath())
		val csrCreds = creds.map { c =>
			val direct = IvyCredentials.toDirect(c)
			Credentials(
				host = direct.host,
				username = direct.userName,
				password = direct.passwd,
				realm = direct.realm
			)
		}

		// filter out fetlock injected deps, as they won't be needed for the actual build
		// (and may cause evictions)
		def removeFetlockDeps(deps: Seq[ModuleID]): List[ModuleID] = deps.toList.filter { dep =>
			val fetlockInternal = dep.extraAttributes.get("fetlockInternal")
			fetlockInternal != Some("true")
		}

		val moduleSets = List(
			// we result multiple independent modulesets rather than everything at once, because
			// version conflicts / evictions would cause different results
			
			ModuleSet("project", removeFetlockDeps(Keys.libraryDependencies.value)),

			ModuleSet("project (test)",
				removeFetlockDeps((sbt.Test / Keys.libraryDependencies).value),
				includeTest = true
			),

			// SBT fetches scala-compiler before it can build anything
			ModuleSet(
				s"scalac ${scalaVersion}",
				List(ModuleID("org.scala-lang", "scala-compiler", scalaVersion)),
				// seems necessary to resolve jline for scala-compiler
				mapFetch = fetch => fetch.withResolutionParams(fetch.resolutionParams.withKeepOptionalDependencies(true))
			),
			
			// bridge module for the version of SBT / scalac we're using
			ModuleSet(
				s"compiler bridge",
				List(sbt.internal.inc.ZincLmUtil.getDefaultBridgeModule(scalaVersion)),
			),
		) ++ {
			if (Keys.isMetaBuild.value) List(
				// SBT resolution is used by SBT launcher
				ModuleSet(
					s"sbt ${Keys.sbtDependency.value.revision}",
					List(Keys.sbtDependency.value)
				),
			) else Nil
		}

		val allArtifacts = moduleSets.map { ms =>
			val cacheArtifactMap = new ConcurrentHashMap[String, (Artifact, Path)]
			val cacheImpl = FileCache[CsrTask](csrCacheRootFile).withCredentials(csrCreds)
			val cacheProxy: Cache[CsrTask] = new Cache[CsrTask] {

				override def file(artifact: Artifact): EitherT[CsrTask,ArtifactError,File] = {
					cacheImpl.file(artifact).map { file =>
						cacheArtifactMap.put(artifact.url, (artifact, file.toPath()))
						file
					}
				}

				override def fetch: Cache.Fetch[CsrTask] = new Cache.Fetch[CsrTask] {
					override def apply(v1: Artifact): EitherT[CsrTask,String,String] = {
						EitherT {
							file(v1).run.map {
								case Left(err) => Left(err.message)
								case Right(file) => Right(new String(Files.readAllBytes(file.toPath), StandardCharsets.UTF_8))
							}
						}
					}
				}

				override def fetchs: Seq[Cache.Fetch[CsrTask]] = Seq(fetch) // TODO?

				override def ec: ExecutionContext = cacheImpl.ec
			}

			var fetch = ms.mapFetch(Fetch(cacheProxy)
				.withDependencies(ms.deps.flatMap(moduleIdToDepencency(ms.includeTest)))
				.withRepositories(repos)
				// .withClassifiers(Set(coursier.Classifier.empty)) // TODO
				.allArtifactTypes())

			val exclusions = Keys.allExcludeDependencies.value.map { excl =>
				(coursier.Organization(excl.organization), coursier.ModuleName(excl.name))
			}.toSet
			fetch = fetch.withResolutionParams(
					fetch.resolutionParams
						.withExclusions(exclusions)
						// TODO convert this from Keys.csrReconciliations instead of hardcoding SBT defaults
						.withReconciliation(List((ModuleMatchers.all, Reconciliation.Relaxed)))
				)

			val _ = fetch.runResult()

			val cached = cacheArtifactMap.asScala.clone()

			println(s"\n### Resolution for ${ms.desc}:")
			ms.deps.foreach { mod =>
				println(s" - ${mod}")
			}
			cached.values.toList.sortBy(_._1.url).foreach { case (a, _) =>
				println(s" + ${a.url}")
			}
			cached
		}.reduce(_ ++ _)

		// Ideally we'd read this from SBT itself. But I can't find anything
		// aside from Resolver, which is an opaque function
		val repoConfig = Option(System.getProperty("sbt.repository.config")).map { path =>
			Files.readString(Path.of(path), StandardCharsets.UTF_8)
		}

		logger.info(s"Writing fetlock JSON to ${sys.env.getOrElse("FETLOCK_OUTPUT", "stdout")}")
		val j = JsonWriter()
		
		j.pushObj {
			j.startElem(); j.key("cache_root"); j.str(csrCacheRoot.toString)
			
			j.startElem(); j.key("repository_config")
			repoConfig match {
				case None => j.nul()
				case Some(config) => j.str(config)
			}
			
			j.startElem(); j.key("dependencies")
			j.pushObj {
				val artifactMap = Map("meta" -> allArtifacts.toList.map { case (_, (a, p)) => CachedArtifact(a, p) })

				artifactMap.foreach { case (key, cached) =>
					// println(cached)
					j.startElem(); j.key(key); j.pushObj {
						j.startElem(); j.key("artifacts"); j.pushArray {
							cached.foreach { cached =>
								val cacheRel = csrCacheRoot.relativize(cached.cachePath)
								if (cacheRel.isAbsolute()) {
									logger.warn(s"Skipping absolute artifact path: ${cacheRel}")
								} else {
									j.startElem(); j.pushObj {
										j.startElem(); j.key("url"); j.str(cached.artifact.url)
										j.startElem(); j.key("cache_path"); j.str(cacheRel.toString())
									}
								}
							}
						}
					}
				}
			}
		}
		j.close()
	}

	case class CachedArtifact(artifact: Artifact, cachePath: Path)
	object CachedArtifact {
		def fromCsr(artifact: Artifact, file: File) = {
			val path = Paths.get(file.getPath())
			CachedArtifact(artifact, Paths.get(file.getPath))
		}
	}
	
	case class ModuleSet(
		desc: String,
		deps: List[ModuleID],
		exclude: List[ModuleID] = Nil,
		includeTest: Boolean = false,
		mapFetch: Fetch[CsrTask] => Fetch[CsrTask] = identity
	)
}
