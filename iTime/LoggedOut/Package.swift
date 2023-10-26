// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggedOut",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LoggedOut",
            targets: ["LoggedOut"]
        ),
        .library(
            name: "LoggedOutImpl",
            targets: ["LoggedOutImpl"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "LoggedOut",
            dependencies: [
                "Domain"
            ]),
        .target(
            name: "LoggedOutImpl",
            dependencies: [
                "Domain"
            ]
        ),
        .testTarget(
            name: "LoggedOutTests",
            dependencies: ["LoggedOut"]),
    ]
)
