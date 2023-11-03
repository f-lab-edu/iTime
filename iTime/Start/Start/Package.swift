// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Start",
    products: [
        .library(
            name: "Start",
            targets: ["Start"]),
        .library(
            name: "StartImpl",
            targets: ["StartImpl"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Start",
            dependencies: [
              "StartImpl"
            ]),
        .testTarget(
            name: "StartTests",
            dependencies: ["Start"]),
    ]
)
