// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "AutoAPI",
    products: [
        .library(name: "AutoAPI", type: .dynamic, targets: ["AutoAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/highmobility/hm-utilities-swift", .branch("master")),
    ],
    targets: [
        .target(name: "AutoAPI", dependencies: ["HMUtilities"], exclude: ["Resources"]),
        .target(name: "AutoAPICLT", dependencies: ["AutoAPI"]),
        .testTarget(name: "AutoAPITests", dependencies: ["AutoAPI"], exclude: ["Resources"]),
    ]
)
