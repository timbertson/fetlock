package net.gfxmonk.fetlock.derive

import java.nio.file.{Path, Paths, Files}

import scala.collection.mutable
import scala.util.Properties

import sbt.Scoped.richTaskSeq
import sbt._
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
			
			def str(s: String) = {
				// TODO escape
				out.print('"')
				out.print(s)
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
		val generateFetlockOutput: TaskKey[Unit] = taskKey("output generated for fetlock to use")
	}

	import autoImport._
	

	override def trigger = allRequirements
	override def requires: Plugins = JvmPlugin

	override def globalSettings: Seq[Setting[_]] = Def.settings(
		// generateFetlockOutput := run.value
		// Keys.commands ++= SubmitDependencyGraph.commands
	)

	override def projectSettings: Seq[Setting[_]] = Def.settings(
		generateFetlockOutput := run.value
		// githubDependencyManifest := manifestTask.value,
		// githubDependencyManifest / Keys.aggregate := false
	)

	private val run = Def.task {
		val reportResult = Keys.updateFull.result.value
		val projectID = Keys.projectID.value
		// val root = Paths.get(Keys.loadedBuild.value.root).toAbsolutePath
		val scalaVersion = (Keys.artifactName / Keys.scalaVersion).value
		val scalaBinaryVersion = (Keys.artifactName / Keys.scalaBinaryVersion).value
		val crossVersion = CrossVersion.apply(scalaVersion, scalaBinaryVersion)
		// val allDirectDependencies = Keys.allDependencies.value
		// val baseDirectory = Keys.baseDirectory.value
		val logger = Keys.streams.value.log

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

			j.startElem(); j.key("dependencies")
			j.pushObj {
				reportResult match {
					case Inc(cause) =>
						throw new RuntimeException(s"Failed to resolve the dependencies of $moduleName")
					case Value(report) => {
						val alreadySeen = mutable.Set[String]()
						// val moduleReports = mutable.Buffer[(ModuleReport, ConfigRef)]()
						// val allDependencies = mutable.Buffer[(String, String)]()
						for {
							configReport <- report.configurations
							// if includeConfig(configReport.configuration)
							moduleReport <- configReport.modules
							moduleRef = getReference(moduleReport.module)
							if !moduleReport.evicted && !alreadySeen.contains(moduleRef)
						} {
							alreadySeen += moduleRef
							j.startElem(); j.key(moduleRef)

							j.pushObj {
								// moduleReports += (moduleReport -> configReport.configuration)
								scala.Console.err.println(s"module report: ${moduleReport.detailReport}")
								scala.Console.err.println(s"module resolver: ${moduleReport.resolver}")
								scala.Console.err.println(s"module artifact resolver: ${moduleReport.artifactResolver}")
								
								j.startElem(); j.key("name"); j.str(moduleReport.module.name)
								j.startElem(); j.key("version"); j.str(moduleReport.module.revision)

								j.startElem()
								j.key("artifacts")
								j.pushArray {

									var pomPaths = mutable.Set.empty[Path]
									for ((artifact, file) <- moduleReport.artifacts) {
										scala.Console.err.println(s"Artifact $artifact @ file $file")
										artifact.url match {
											case None => {}
											case Some(url) => {
												val path = Paths.get(file.getPath)
												if (path.startsWith(csrCache)) {
													
													// TODO: we detect pom files by just looking for an adjacent one in the cache.
													// That's pretty naff, and what happens for ivy? Surely there's a way for
													// SBT / coursier to tell me about the original module metadata file.
													val filename = path.getFileName().toString()
													val pomFilename = filename.split("\\.").dropRight(1).mkString(".") + ".pom"
													val pomPath = path.getParent().resolve(pomFilename)
													scala.Console.err.println(s"Checking filename $filename parts ${filename.split(".").toList} dropr ${filename.split(".").dropRight(1)} pomFilename $pomFilename pompath $pomPath")
													if (!pomPaths.contains(pomPath) && Files.exists(pomPath)) {
														pomPaths.add(pomPath)
														j.startElem()
														j.pushObj {
															val pomUrl = url.toString.split("/").dropRight(1).mkString("/") + "/" + pomFilename
															j.startElem(); j.key("url"); j.str(pomUrl)
															j.startElem(); j.key("cache_path"); j.str(csrCache.relativize(pomPath).toString)
														}
													}
														
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
								}
							}
							// for (caller <- moduleReport.callers)
							//	allDependencies += (getReference(caller.caller) -> moduleRef)
						}
					}
				}
			}
		}
		j.close()
	}

}
