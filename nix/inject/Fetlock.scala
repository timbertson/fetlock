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
		
		case class Artifact(url: String, path: Path)
		object Artifact {
			def fromSbt(artifact: sbt.Artifact, file: File): Option[Artifact] =
				artifact.url.map(url => Artifact(url.toString, Paths.get(file.getPath)))
		}
		

		class CacheLogic(csrCache: Path) {
			def detectCacheLocation(module: ModuleID, artifact: Artifact): Option[ModuleCacheLocation] = {
				if (artifact.path.startsWith(csrCache)) {
					val moduleParts = ModuleCacheLocation.moduleUrlRelPaths(module).head.split('/').size

					val urlBase = artifact.url.toString.split('/').dropRight(moduleParts).mkString("/")
					val fileBase = artifact.path.toString.split('/').dropRight(moduleParts).mkString("/")

					Some(ModuleCacheLocation(urlBase = urlBase, fileBase = fileBase))
				} else {
					None
				}
			}

			def emitArtifact(j: JsonWriter, artifact: Artifact): Unit = {
				if (artifact.path.startsWith(csrCache) && Files.exists(artifact.path)) {
					j.startElem()
					j.pushObj {
						j.startElem(); j.key("url"); j.str(artifact.url.toString)
						j.startElem(); j.key("cache_path"); j.str(csrCache.relativize(artifact.path).toString)
					}
				} else {
					println(s"Note: path ${artifact.path} is missing or outside coursier cache $csrCache; ignoring")
				}
			}
		}
		
		case class ModuleCacheLocation(urlBase: String, fileBase: String) {
			def moduleArtifacts(id: ModuleID): List[Artifact] = {
				extantModuleArtifacts(id).flatMap(a => artifactWithParents(a))
			}
			
			private def extantModuleArtifacts(id: ModuleID): List[Artifact] = {
				val relPaths = ModuleCacheLocation.moduleUrlRelPaths(id)
				relPaths.flatMap { relPath =>
					val pomUrl = s"${urlBase}/${relPath}"
					val pomPath = Paths.get(s"${fileBase}/${relPath}")
					if (Files.exists(pomPath)) {
						List(Artifact(pomUrl, pomPath))
					} else {
						println(s"Ignoring missing pom path: ${pomPath}")
						Nil
					}
				}
			}

			private def artifactWithParents(artifact: Artifact, isParent: Boolean = false): List[Artifact] = {
				import org.apache.maven.model.building._
				import org.apache.maven.model.{Repository, Parent, Dependency}
				import org.apache.maven.model.resolution.ModelResolver

				val path = artifact.path

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
				
				val parentArtifacts: List[Artifact] = parentModel.map(parent => ModuleID(
					organization = parent.getGroupId(),
					name = parent.getArtifactId(),
					revision = parent.getVersion()
				)).toList.flatMap(extantModuleArtifacts)

				// load parents recursively
				artifact :: (parentArtifacts.flatMap(a => artifactWithParents(a, true)))
			}

		}
		
		object ModuleCacheLocation {
			def moduleUrlRelPaths(id: ModuleID): List[String] = {
				val canonical = s"${id.organization.split('.').mkString("/")}/${id.name}/${id.revision}/${id.name}-${id.revision}.pom"

				// SBT plugins are historically published with an invalid but working maven path:
				// https://github.com/sbt/website/pull/1164/files#r1379000619
				val sbtPluginLegacy = (id.extraAttributes.get("scalaVersion"), id.extraAttributes.get("sbtVersion")) match {
					case (Some(scala), Some(sbt)) => List(
						s"${id.organization.split('.').mkString("/")}/${id.name}_${scala}_${sbt}/${id.revision}/${id.name}-${id.revision}.pom",
						s"${id.organization.split('.').mkString("/")}/${id.name}_${scala}_${sbt}/${id.revision}/${id.name}_${scala}_${sbt}-${id.revision}.pom"
					)
					case _ => Nil
				}
				canonical :: sbtPluginLegacy
			}
		}
		
		case class Project(org: String, name: String) {
			def key = s"$org.$name"
		}

		object Project {
			def from(moduleId: ModuleID) = Project(moduleId.organization, moduleId.name)
		}

		case class MyModuleReport(artifacts: Set[Artifact], versions: Set[ModuleID]) {
			def mergeFrom(other: ModuleReport) = {
				val convertedArtifacts = other.artifacts
					.flatMap { case (artifact, path) => Artifact.fromSbt(artifact, path) }
					.toSet
				MyModuleReport(
					versions = this.versions + other.module,
					artifacts = this.artifacts.union(convertedArtifacts),
				)
			}
		}

		object MyModuleReport {
			val empty = MyModuleReport(Set.empty, Set.empty)
			def fromSbt(report: ModuleReport): MyModuleReport = empty.mergeFrom(report)
		}

		def mergeModuleReports(allReports: List[Option[UpdateReport]]): Map[Project, MyModuleReport] = {
			var usedModules = Map.empty[Project, MyModuleReport]

			allReports.foreach {
				case None => throw new RuntimeException(s"Failed to resolve the dependencies")
				case Some(report) => {
					// We need to include evicted modules so that SBT in the final build
					// has enough metadata to recreate the solution.
					for {
						configReport <- report.configurations
						orgArtifactReport <- configReport.details
						moduleReport <- orgArtifactReport.modules
						// if moduleReport.evicted
						// moduleRef = getReference(moduleReport.module)
					} {
						val project = Project.from(moduleReport.module)
						// if (project.name.contains("sbt-git")) {
						// 	println(s"sbt-git: extraattr = ${moduleReport.module.extraAttributes}, conf = ${moduleReport.module.configurations}, branch = ${moduleReport.module.branchName}")
						// }
						val newValue = usedModules.getOrElse(project, MyModuleReport.empty).mergeFrom(moduleReport)
						usedModules = usedModules.updated(project, newValue)
					}
				}
			}
			usedModules
		}
	}

	object autoImport {
		val fetlockGenerate: TaskKey[Unit] = taskKey("output generated for fetlock to use")
	}

	import autoImport._
	import Internal._

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
			// .withArtifactFilter(ArtifactTypeFilter.allow(Set("pom")))
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
		val j = JsonWriter()

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
			
			val allModules = mergeModuleReports(allReports)
			val cacheLogic = new CacheLogic(csrCache)

			j.startElem(); j.key("dependencies")
			j.pushObj {

				// Output all the used modules, including artifacts via every dependency path, and any eviction-relatd artifacts.
				allModules.toList.sortBy(_._1.key).foreach { case (key, module) =>
					scala.Console.err.println(s"* ${key.key} moduleIDs: ${module.versions.map(getReference)}, ${module.artifacts.size} artifacts")
					if (module.artifacts.isEmpty) {
						println(s"WARN: skipping module ${key.key} with no artifacts")
					} else {
						// TODO how do we end up with empty modules? Does that mean they're all evicted? Or are there
						// modules which genuinely have no files?
						j.startElem(); j.key(key.key); j.pushObj {

							var moduleCacheLocation = Option.empty[ModuleCacheLocation]

							// TODO: should MyModule track the _used_ version? I think it's fine to use an arbitrary version, it results in the same path properties
							val arbitraryVersion = module.versions.toList.sortBy(_.revision).head

							j.startElem(); j.key("artifacts"); j.pushArray {
								module.artifacts.foreach { artifact =>
									moduleCacheLocation = moduleCacheLocation.orElse(cacheLogic.detectCacheLocation(arbitraryVersion, artifact))
									cacheLogic.emitArtifact(j, artifact)
								}
								
								val cache = moduleCacheLocation.getOrElse {
									val artifactPaths = module.artifacts.map(_.path)
									throw new RuntimeException(s"Unable to determine cache location from artifacts for module ${key}.\nCache path: ${csrCache}\nArtifact paths:${artifactPaths.mkString("\n - ", "\n - ", "")}")
								}

								module.versions.foreach { moduleId =>
									cache.moduleArtifacts(moduleId).foreach { artifact =>
										cacheLogic.emitArtifact(j, artifact)
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
