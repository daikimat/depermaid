// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ExampleDepermaidAnimalPackage",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(path: "../../../depermaid"),
        .package(path: "./Library"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        .target(
            name: "Example",
            dependencies: [
                "Cat",
                "Dog"
            ]
        ),
        .target(
            name: "Cat",
            dependencies: [
                "AnimalClient",
                "AnimalMacros"
            ]
        ),
        .target(
            name: "Dog",
            dependencies: [
                "AnimalClient"
            ]
        ),
        .target(
            name: "AnimalClient",
            dependencies: [
                .product(name: "LifeCore", package: "Library")
            ]
        ),
        .testTarget(
            name: "AnimalClientTests",
            dependencies: [
                "AnimalClient"
            ]
        ),
        .executableTarget(
            name: "ExecutableExample",
            dependencies: [
                "Dog"
            ]
        ),
        .macro(
            name: "AnimalMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
    ]
)
