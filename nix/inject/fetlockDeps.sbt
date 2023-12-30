ThisBuild / libraryDependencies ++= {
	val version = "2.1.8"
	def markFetlock(m: ModuleID) = m.withExtraAttributes(Map("fetlockInternal" -> "true"))
	Seq(
		"io.get-coursier" %% "coursier" % version,
		"io.get-coursier" %% "coursier-sbt-maven-repository" % version,
		"org.scala-sbt" %% "zinc-lm-integration" % sbtVersion.value
	).map(markFetlock)
}
