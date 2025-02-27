load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

def scala_2_12_artifacts():
    return [
        "org.scala-lang:scala-compiler:2.12.14",
        "org.scala-lang:scala-library:2.12.14",
        "org.scala-lang:scala-reflect:2.12.14",
        # The compiler bridge has a dependency on compiler-interface, which has a dependency on the Scala 2
        # library. We need to set this to neverlink = True to avoid this the Scala 2 library being pulled
        # onto the Scala 3, and other Scala versions like 2.12, compiler classpath during runtime.
        maven.artifact("org.scala-sbt", "compiler-bridge_2.12", "1.5.7", neverlink = True),
    ]

def scala_2_12_repositories():
    maven_install(
        name = "annex_2_12",
        artifacts = scala_2_12_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_2_12_install.json",
    )
