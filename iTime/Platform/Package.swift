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
      name: "LocalDataBaseRepositoryImpl",
      targets: ["LocalDataBaseRepositoryImpl"]),
    .library(
      name: "NetworkRepositoryImpl",
      targets: ["NetworkRepositoryImpl"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "LocalDataBaseRepositoryImpl",
      dependencies: [
        .product(name: "LocalDataBaseRepository", package: "Domain"),
        "ProxyPackage",
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .target(
      name: "NetworkRepositoryImpl",
      dependencies: [
        .product(name: "NetworkRepository", package: "Domain"),
        .product(name: "LocalDataBaseRepository", package: "Domain"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .testTarget(
      name: "NetworkRepositoryImplTests",
      dependencies: [
        "NetworkRepositoryImpl",
        "LocalDataBaseRepositoryImpl",
        .product(name: "NetworkRepository", package: "Domain"),
        .product(name: "LocalDataBaseRepository", package: "Domain"),
        .product(name: "RepositoryTestSupports", package: "Domain"),
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "ProxyTestSupport", package: "ProxyPackage"),
      ]
    ),
  ]
)
