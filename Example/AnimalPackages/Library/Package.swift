// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LifeCore",
    products: [
        .library(
            name: "LifeCore",
            targets: ["LifeCore"]
        )
    ],
    targets: [
        .target(
            name: "LifeCore"
        )
    ]
)

