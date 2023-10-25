// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Platform",
            targets: ["Platform"]),
    ],
    dependencies: [
        .package(path: "../ProxyPackage")
    ],
    targets: [
        .target(
            name: "Platform",
            dependencies: [
                "ProxyPackage"
            ]),
        .testTarget(
            name: "PlatformTests",
            dependencies: ["Platform"]),
    ]
)
