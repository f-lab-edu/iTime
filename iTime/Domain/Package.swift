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
    
  ],
  dependencies: [
    .package(path: "../Platform"),
    .package(path: "../ProxyPackage"),
  ],
  targets: [
    .target(
      name: "AuthenticationUsecase",
      dependencies: [
        .product(name: "AuthenticationRepository", package: "Platform"),
        "ProxyPackage",
      ]),
    .target(
      name: "AuthenticationUsecaseImpl",
      dependencies: [
        "AuthenticationUsecase",
        .product(name: "AuthenticationRepository", package: "Platform"),
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
        .product(name: "AuthenticationRepository", package: "Platform"),
        .product(name: "RepositoryTestSupports", package: "Platform"),
      ]),
    .testTarget(
      name: "BookmarkUsecaseImplTests",
      dependencies: [
        "BookmarkUsecase",
        "BookmarkUsecaseImpl",
        .product(name: "RepositoryTestSupports", package: "Platform"),
      ]),
  ]
)
