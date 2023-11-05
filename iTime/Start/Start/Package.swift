// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Start",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Start",
            targets: ["Start"]),
        .library(
            name: "StartImpl",
            targets: ["StartImpl"]),
    ],
    dependencies: [
      .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Start",
            dependencies: ["Domain"]),
        .target(
            name: "StartImpl",
            dependencies: [
              "Start",
              "Domain"
            ]),
        .testTarget(
            name: "StartTests",
            dependencies: ["Start"]),
    ]
)
