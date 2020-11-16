// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AutoAPI",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "AutoAPI",
                 targets: ["AutoAPI"]
        ),
//        .library(name: "AutoAPIGraphQL",
//                 targets: ["AutoAPIGraphQL"]
//        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "HMUtilities",
                 url: "https://github.com/highmobility/hmutilities-swift",
                 .upToNextMinor(from: "1.4.7")
        ),

        // For the GraphQL lib
//        .package(url: "https://github.com/vapor/vapor.git",
//                 from: "4.3.0"
//
//        ),
//        .package(name: "GraphQLKit",
//                 url: "https://github.com/IThomas/graphql-kit.git",
//                 from: "2.0.0-beta.5"
//        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "AutoAPI",
                dependencies: [
                    "HMUtilities"
                ]
        ),
//        .target(name: "AutoAPIGraphQL",
//                dependencies: [
//                    "AutoAPI",
//                    "HMUtilities",
//                    .product(name: "GraphQLKit", package: "GraphQLKit"),
//                    .product(name: "Vapor", package: "vapor"),
//                ]
//        ),
        .testTarget(name: "AutoAPITests",
                    dependencies: ["AutoAPI"]
        ),
    ]
)
