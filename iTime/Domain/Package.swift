// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Domain",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Entities",
      targets: ["Entities"]),
    .library(
      name: "Repository",
      targets: ["Repository"]),
    .library(
      name: "RepositoryTestSupports",
      targets: ["RepositoryTestSupports"]),
    .library(
      name: "Usecase",
      targets: ["Usecase"]),
    .library(
      name: "UsecaseImpl",
      targets: ["UsecaseImpl"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
  ],
  targets: [
    .target(
      name: "Entities",
      dependencies: [
      ]),
    .target(
      name: "Repository",
      dependencies: [
        "ProxyPackage",
      ]),
    .target(
      name: "Usecase",
      dependencies: [
        "Entities",
        "ProxyPackage",
      ]),
    .target(
      name: "UsecaseImpl",
      dependencies: [
        "Usecase",
        .product(name: "AppFoundation", package: "ProxyPackage")
      ]),
    .target(
      name: "RepositoryTestSupports",
      dependencies: [
        "Repository",
        .product(name: "BaseRepository", package: "ProxyPackage"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .testTarget(
      name: "UsecaseImplTests",
      dependencies: [
        "Usecase",
        "UsecaseImpl",
        "Repository",
        "RepositoryTestSupports",
      ]),
  ]
)
