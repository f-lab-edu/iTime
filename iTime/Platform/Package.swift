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
      name: "RepositoryImpl",
      targets: ["RepositoryImpl"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "RepositoryImpl",
      dependencies: [
        .product(name: "Repository", package: "Domain"),
        "ProxyPackage",
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .testTarget(
      name: "RepositoryImplTests",
      dependencies: [
        "RepositoryImpl",
        .product(name: "Repository", package: "Domain"),
        .product(name: "RepositoryTestSupports", package: "Domain"),
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "ProxyTestSupport", package: "ProxyPackage"),
      ]
    ),
  ]
)
