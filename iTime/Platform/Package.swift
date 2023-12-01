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
    .library(
      name: "Models",
      targets: ["Models"]),
    .library(
      name: "Translator",
      targets: ["Translator"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "Models",
      dependencies: [
      ]),
    .target(
      name: "RepositoryImpl",
      dependencies: [
        .product(name: "Repository", package: "Domain"),
        "ProxyPackage",
        "Models",
        "Translator",
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .target(
      name: "Translator",
      dependencies: [
        "Models",
        .product(name: "Entities", package: "Domain"),
      ]),
    .testTarget(
      name: "RepositoryImplTests",
      dependencies: [
        "RepositoryImpl",
        "Translator",
        .product(name: "Entities", package: "Domain"),
        .product(name: "Repository", package: "Domain"),
        .product(name: "RepositoryTestSupports", package: "Domain"),
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "ProxyTestSupport", package: "ProxyPackage"),
      ]
    ),
  ]
)
