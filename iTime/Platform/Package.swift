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
            name: "NetworkRepository",
            targets: ["NetworkRepository"]),
        .library(
            name: "NetworkRepositoryImpl",
            targets: ["NetworkRepositoryImpl"]),
        .library(
            name: "RepositoryTestSupports",
            targets: ["RepositoryTestSupports"]),
    ],
    dependencies: [
        .package(path: "../ProxyPackage"),
    ],
    targets: [
        .target(
            name: "NetworkRepository",
            dependencies: [
                "ProxyPackage"
            ]),
        .target(
            name: "NetworkRepositoryImpl",
            dependencies: [
                "NetworkRepository",
                "ProxyPackage",
                .product(name: "AppFoundation", package: "ProxyPackage"),
            ]),
        .target(
            name: "RepositoryTestSupports",
            dependencies: [
                "NetworkRepository",
                "ProxyPackage",
            ]),
        .testTarget(
            name: "NetworkRepositoryImplTests",
            dependencies: [
              "NetworkRepository",
              "NetworkRepositoryImpl",
              "RepositoryTestSupports",
            ]
        ),
    ]
)
