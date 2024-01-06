// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "depermaid",
    products: [
        .plugin(name: "depermaid", targets: ["Depermaid"]),
    ],
    targets: [
        .plugin(
            name: "Depermaid",
            capability: .command(
                intent: .custom(verb: "depermaid", description: "Generate Swift dependency visualizations using Mermaid notation from Swift Package."),
                permissions: []
            )
        )
    ]
)
