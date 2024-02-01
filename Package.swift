// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "depermaid",
    products: [
        .plugin(name: "depermaid", targets: ["Depermaid"]),
    ],
    targets: [
        .testTarget(
            name: "DepermaidTests",
            dependencies: [
                // Restriction that Test cannot depend on Plugin, so use symbolic links for testing.
            ]
        ),
        .plugin(
            name: "Depermaid",
            capability: .command(
                intent: .custom(verb: "depermaid", description: "Generate Swift dependency visualizations using Mermaid notation from Swift Package."),
                permissions: []
            )
        )
    ]
)
