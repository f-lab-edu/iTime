// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Platform",
            targets: ["Platform"]),
        .library(
            name: "PlatformImpl",
            targets: ["PlatformImpl"]),
        .library(
            name: "PlatformTestSupports",
            targets: ["PlatformTestSupports"]),
    ],
    dependencies: [
        .package(path: "../ProxyPackage"),
        .package(path: "../AppFoundation")
    ],
    targets: [
        .target(
            name: "Platform",
            dependencies: [
                "ProxyPackage"
            ]),
        .target(
            name: "PlatformImpl",
            dependencies: [
                "Platform",
                "AppFoundation",
                "ProxyPackage",
            ]),
        .target(
            name: "PlatformTestSupports",
            dependencies: [
                "Platform",
                "ProxyPackage",
            ]),
        .testTarget(
            name: "PlatformTests",
            dependencies: ["Platform"]),
    ]
)
