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
        .library(
            name: "LogEntryCreation",
            targets: ["LogEntryCreation"]),
        .library(
            name: "LogEntryCreationImpl",
            targets: ["LogEntryCreationImpl"]),
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
        .target(
            name: "LogEntryCreation",
            dependencies: ["Domain"]),
        .target(
            name: "LogEntryCreationImpl",
            dependencies: [
              "LogEntryCreation",
              "Domain"
            ]),
        .testTarget(
            name: "StartTests",
            dependencies: ["Start"]),
        .testTarget(
            name: "LogEntryCreationTests",
            dependencies: ["LogEntryCreation"]),
    ]
)
