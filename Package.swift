// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "AutoAPI",
    products: [
        .library(name: "AutoAPI", type: .static, targets: ["AutoAPI"]),
        .library(name: "AutoAPI", type: .dynamic, targets: ["AutoAPI"])
    ],
    targets: [
        .target(name: "AutoAPI", exclude: ["Resources"]),
        .target(name: "AutoAPI CLT", dependencies: ["AutoAPI"]),
        .testTarget(name: "AutoAPITests", dependencies: ["AutoAPI"], exclude: ["Resources"])
    ]
)
