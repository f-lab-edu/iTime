// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SharedUI",
  defaultLocalization: "en",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "SharedUI",
      targets: ["SharedUI"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
    .package(path: "../AppFoundation"),
  ],
  targets: [
    .target(
      name: "SharedUI",
      dependencies: [
        "ProxyPackage",
        "AppFoundation"
      ]
    ),
    .testTarget(
      name: "SharedUITests",
      dependencies: ["SharedUI"]),
  ]
)
