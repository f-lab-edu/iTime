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
            name: "AuthenticationRepository",
            targets: ["AuthenticationRepository"]),
        .library(
            name: "AuthenticationRepositoryImpl",
            targets: ["AuthenticationRepositoryImpl"]),
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
            name: "AuthenticationRepository",
            dependencies: [
                "NetworkRepository",
            ]),
        .target(
            name: "AuthenticationRepositoryImpl",
            dependencies: [
                "AuthenticationRepository",
                "NetworkRepositoryImpl",
                .product(name: "AppFoundation", package: "ProxyPackage"),
            ]),
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
                "AuthenticationRepository",
                "ProxyPackage",
            ]),
        .testTarget(
            name: "PlatformTests",
            dependencies: ["NetworkRepository"]),
    ]
)
