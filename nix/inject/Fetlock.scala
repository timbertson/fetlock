package net.gfxmonk.fetlock.derive

// import coursier._
// import coursier.core._
// import coursier.util.Artifact
import scala.annotation.nowarn


import java.nio.file.{Path, Paths, Files}
import java.nio.charset.StandardCharsets

import scala.collection.mutable
import scala.util.Properties

import sbt.Scoped.richTaskSeq
import sbt._
import sbt.librarymanagement.{UpdateConfiguration,UnresolvedWarningConfiguration,ArtifactTypeFilter}
import sbt.internal.util.complete.Parser
import scala.collection.mutable
import sbt.internal.util.complete.Parsers
import sbt.plugins.JvmPlugin
import sjsonnew.shaded.scalajson.ast.unsafe.JString
import java.io.OutputStream
import java.io.BufferedOutputStream
import java.io.FileOutputStream
import java.io.PrintWriter

object DeriveDep extends AutoPlugin {
	object Internal {

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
		
		case class CachedArtifact(url: String, path: String)

		def loadParentOf(path: Path, isParent: Boolean = false): Option[ModuleID] = {
			import org.apache.maven.model.building._
			import org.apache.maven.model.{Repository, Parent, Dependency}
			import org.apache.maven.model.resolution.ModelResolver

			// All I really want is the parent coords, if any. Seems like a lot of work :shrug:
			val buildingRequest = new DefaultModelBuildingRequest()
			buildingRequest.setPomFile(path.toFile())
			buildingRequest.setProcessPlugins(false)
			buildingRequest.setValidationLevel(ModelBuildingRequest.VALIDATION_LEVEL_MINIMAL);
			buildingRequest.setSystemProperties(System.getProperties())

			var parentModel = Option.empty[Parent]
			buildingRequest.setModelResolver(new ModelResolver {

				@nowarn("cat=deprecation")
				override def resolveModel(groupId: String, artifactId: String, version: String): ModelSource = null

				@nowarn("cat=deprecation")
				override def resolveModel(parent: Parent): ModelSource = {
					parentModel = Some(parent)
					null
				}

				@nowarn("cat=deprecation")
				override def resolveModel(dependency: Dependency): ModelSource = null
				override def addRepository(repository: Repository): Unit = ()
				override def addRepository(repository: Repository, replace: Boolean): Unit = ()

				override def newCopy(): ModelResolver = this
			})
			
			val modelBuilder = new DefaultModelBuilderFactory().newInstance()
			try {
				modelBuilder.build(buildingRequest)
			} catch {
				case _: java.lang.NullPointerException if parentModel.isDefined || isParent => () // expected
				case other: Exception => {
					println(s"WARN: unexpected error loading pom at ${path} with parent ${parentModel}; ignoring:\n${other.getClass().getName()}: ${other.getMessage()}")
				}
			}
			
			parentModel.map(parent => ModuleID(
				organization = parent.getGroupId(),
				name = parent.getArtifactId(),
				revision = parent.getVersion()
			))
		}

		class MetadataTracker(csrCache: Path, j: JsonWriter) {
			private val pomPaths = mutable.Set.empty[Path]

			def emitArtifact(module: ModuleID, url: URL, path: Path): Unit = {
				if (path.startsWith(csrCache)) {
					// TODO: we detect pom files by just looking for an adjacent one in the cache.
					// That's pretty naff, and what happens for ivy? Surely there's a way for
					// SBT / coursier to tell me about the original module metadata file.
					
					def moduleUrlPath(id: ModuleID): String = {
						s"${id.organization.split('.').mkString("/")}/${id.name}/${id.revision}/${id.name}-${id.revision}.pom"
					}
					
					val moduleParts = moduleUrlPath(module).split('/').size

					val urlBase = url.toString.split('/').dropRight(moduleParts).mkString("/")
					val fileBase = path.toString.split('/').dropRight(moduleParts).mkString("/")

					def addModulePom(id: ModuleID) {
						val relPath = moduleUrlPath(id)
						val pomUrl = s"${urlBase}/${relPath}"
						val pomPath = Paths.get(s"${fileBase}/${relPath}")
						if (!pomPaths.contains(pomPath)) {
							if (Files.exists(pomPath)) {
								// scala.Console.err.println(s"Adding pom ${pomPath}")
								// firstly, declare the POM artifact
								pomPaths.add(pomPath)
								j.startElem()
								j.pushObj {
									j.startElem(); j.key("url"); j.str(pomUrl)
									j.startElem(); j.key("cache_path"); j.str(csrCache.relativize(pomPath).toString)
								}
								
								// then, do the parent if there is one
								loadParentOf(pomPath, isParent = true).foreach { parent =>
									addModulePom(parent)
								}
							} else {
								scala.Console.err.println(s"WARN: expected POM path $pomPath doesn't exist in cache; ignoring")
							}
						}
					}
					addModulePom(module)
					
					j.startElem()
					j.pushObj {
						j.startElem(); j.key("url"); j.str(url.toString)
						j.startElem(); j.key("cache_path"); j.str(csrCache.relativize(path).toString)
					}
				} else {
					scala.Console.err.println(s"Note: path $path is not inside coursier cache $csrCache; ignoring")
				}
			}
		}
	}

	object autoImport {
		val fetlockGenerate: TaskKey[Unit] = taskKey("output generated for fetlock to use")
	}

	import autoImport._
	

	override def trigger = allRequirements
	override def requires: Plugins = JvmPlugin

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
		val updateConfiguration = UpdateConfiguration()
			.withArtifactFilter(ArtifactTypeFilter.allow(Set("pom")))
		val uwConfig = UnresolvedWarningConfiguration()
		val projectID = Keys.projectID.value
		// val root = Paths.get(Keys.loadedBuild.value.root).toAbsolutePath
		val scalaVersion = (Keys.artifactName / Keys.scalaVersion).value
		val scalaBinaryVersion = (Keys.artifactName / Keys.scalaBinaryVersion).value
		val crossVersion = CrossVersion.apply(scalaVersion, scalaBinaryVersion)
		// val allDirectDependencies = Keys.allDependencies.value
		// val baseDirectory = Keys.baseDirectory.value
		val logger = Keys.streams.value.log
		val sbtModule = Keys.sbtDependency.value
		// val sbtTestDepsShouldntBeRequiredButEh = Vector(
		// 	ModuleId("")
		// )

		val allReports = List(
			// SBT itself
			// TODO does this do sources? I don't need those...
			// Keys.updateSbtClassifiers.result.value.toEither.toOption,
			Keys.bootDependencyResolution.result.value.toEither.toOption.flatMap { dep =>
				dep.update(
					module = dep.moduleDescriptor(
						moduleId = projectID,
						directDependencies = Vector(sbtModule),
						scalaModuleInfo = None,
					),
					configuration = updateConfiguration,
					uwconfig = uwConfig,
					log = logger,
				).toOption
			},

			// project deps
			Keys.updateFull.result.value.toEither.toOption,
			// Keys.updateClassifiers.result.value.toEither.toOption,
			// Keys.updateSbtClassifiers.result.value.toEither.toOption,
		)
		
		// Ideally we'd read this from SBT itself. But I can't find anything
		// aside from Resolver, which is an opaque function
		val repoConfig = Option(System.getProperty("sbt.repository.config")).map { path =>
			Files.readString(Path.of(path), StandardCharsets.UTF_8)
		}

		logger.info(s"Writing fetlock JSON to ${sys.env.getOrElse("FETLOCK_OUTPUT", "stdout")}")
		val j = Internal.JsonWriter()

		// val state = Keys.state.value

		def getReference(module: ModuleID): String =
			crossVersion(module)
				.withConfigurations(None)
				.withExtraAttributes(Map.empty)
				.toString

		val moduleName = crossVersion(projectID).name

		j.pushObj {
			val csrCache = Paths.get(Keys.csrCacheDirectory.value.getPath)
			j.startElem(); j.key("cache_root"); j.str(csrCache.toString)
			
			j.startElem(); j.key("repository_config")
			repoConfig match {
				case None => j.nul()
				case Some(config) => j.str(config)
			}

			j.startElem(); j.key("dependencies")
			j.pushArray {
				allReports.foreach {
					case None => throw new RuntimeException(s"Failed to resolve the dependencies of $moduleName")
					case Some(report) => {
						for {
							configReport <- report.configurations
							// moduleReport <- configReport.modules
							orgArtifactReport <- configReport.details
							moduleReport <- orgArtifactReport.modules
							moduleRef = getReference(moduleReport.module)
						} {
							j.startElem()
							j.pushObj {
								j.startElem(); j.key("key"); j.str(moduleRef)
								j.startElem(); j.key("name"); j.str(moduleReport.module.name)
								j.startElem(); j.key("version"); j.str(moduleReport.module.revision)
								
								j.startElem(); j.key("evicted"); j.bool(moduleReport.evicted)

								// j.startElem(); j.key("callers"); j.pushArray {
								// 	moduleReport.callers.foreach { caller =>
								// 		j.startElem()
								// 		j.str(getReference(caller.moduleId))
								// 	}
								// }

								j.startElem()
								j.key("artifacts")
								j.pushArray {

									val metadataTracker = new Internal.MetadataTracker(csrCache, j)
									for ((artifact, file) <- moduleReport.artifacts) {
										// scala.Console.err.println(s"   - Artifact $artifact @ file $file")
										artifact.url match {
											case None => {}
											case Some(url) => {
												val path = Paths.get(file.getPath)
												metadataTracker.emitArtifact(moduleReport.module, url, path)
											}
										}
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

}
