// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExampleDepermaidComplexPackages",
    dependencies: [
        .package(path: "../../../depermaid"),
    ],
    targets: [
        .target(
            name: "A",
            dependencies: [
                "B",
                "C",
                "D",
                "E"
            ]
        ),
        .target(
            name: "B",
            dependencies: [
                "C",
                "D",
                "E"
            ]
        ),
        .target(
            name: "C",
            dependencies: [
                "D",
                "E"
            ]
        ),
        .target(
            name: "D"
        ),
        .target(
            name: "E"
        ),
    ]
)
