// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppFoundation",
  defaultLocalization: "en",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "AppFoundation",
      targets: ["AppFoundation"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage")
  ],
  targets: [
    .target(
      name: "AppFoundation",
      dependencies: [
      "ProxyPackage"
      ]
    ),
      .testTarget(
        name: "AppFoundationTests",
        dependencies: ["AppFoundation"]),
  ]
)
