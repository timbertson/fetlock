ThisBuild / libraryDependencies += "org.apache.maven" % "maven-model-builder" % "3.9.6"
ThisBuild / libraryDependencies ++= {
	val version = "2.1.8"
	Seq(
		"io.get-coursier" %% "coursier" % version,
		"io.get-coursier" %% "coursier-sbt-maven-repository" % version,
	)
}
