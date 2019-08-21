// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "AutoAPI",
    products: [
        .library(name: "AutoAPI", targets: ["AutoAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/highmobility/hm-utilities-swift", .upToNextMinor(from: "1.4.1")),
    ],
    targets: [
        .target(name: "AutoAPI", dependencies: ["HMUtilities"]),
        .testTarget(name: "AutoAPITests", dependencies: ["AutoAPI"]),
    ]
)
