// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggedIn",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LoggedIn",
            targets: ["LoggedIn"]),
        .library(
            name: "LoggedInImpl",
            targets: ["LoggedInImpl"]),
    ],
    dependencies: [
      .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "LoggedIn",
            dependencies: ["Domain"]),
        .target(
            name: "LoggedInImpl",
            dependencies: [
              "LoggedIn",
              "Domain",
            ]),
        .testTarget(
            name: "LoggedInTests",
            dependencies: ["LoggedIn"]),
    ]
)
