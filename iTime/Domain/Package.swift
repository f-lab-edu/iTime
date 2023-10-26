// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                "Platform"
            ]),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
    ]
)
