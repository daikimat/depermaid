// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExampleDepermaidAnimalPackage",
    dependencies: [
        .package(path: "../../../depermaid"),
        .package(path: "./Library")
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
                "AnimalClient"
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
    ]
)
