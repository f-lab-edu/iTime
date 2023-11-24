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
      name: "AuthenticationUsecase",
      targets: ["AuthenticationUsecase"]),
    .library(
      name: "AuthenticationUsecaseImpl",
      targets: ["AuthenticationUsecaseImpl"]),
    .library(
      name: "BookmarkUsecase",
      targets: ["BookmarkUsecase"]),
    .library(
      name: "BookmarkUsecaseImpl",
      targets: ["BookmarkUsecaseImpl"]),
    .library(
        name: "LocalDataBaseRepository",
        targets: ["LocalDataBaseRepository"]),
    .library(
      name: "NetworkRepository",
      targets: ["NetworkRepository"]),
    .library(
      name: "RepositoryTestSupports",
      targets: ["RepositoryTestSupports"]),
  ],
  dependencies: [
    .package(path: "../ProxyPackage"),
  ],
  targets: [
    .target(
      name: "AuthenticationUsecase",
      dependencies: [
        "NetworkRepository",
        "ProxyPackage",
      ]),
    .target(
      name: "AuthenticationUsecaseImpl",
      dependencies: [
        "AuthenticationUsecase",
        "NetworkRepository",
        .product(name: "AppFoundation", package: "ProxyPackage")
      ]),
    .target(
      name: "BookmarkUsecase",
      dependencies: [
        "ProxyPackage",
      ]),
    .target(
      name: "BookmarkUsecaseImpl",
      dependencies: [
        "BookmarkUsecase",
        .product(name: "AppFoundation", package: "ProxyPackage")
      ]),
    .testTarget(
      name: "AuthenticationUsecaseImplTests",
      dependencies: [
        "AuthenticationUsecase",
        "AuthenticationUsecaseImpl",
        "NetworkRepository",
        "RepositoryTestSupports",
      ]),
    .testTarget(
      name: "BookmarkUsecaseImplTests",
      dependencies: [
        "BookmarkUsecase",
        "BookmarkUsecaseImpl",
        "RepositoryTestSupports",
      ]),
    .target(
        name: "LocalDataBaseRepository",
        dependencies: [
            "ProxyPackage"
        ]),
    .target(
        name: "NetworkRepository",
        dependencies: [
            "ProxyPackage"
        ]),
    .target(
      name: "RepositoryTestSupports",
      dependencies: [
        "NetworkRepository",
        "LocalDataBaseRepository",
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
  ]
)
