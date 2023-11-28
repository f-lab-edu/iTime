// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "AppRoot",
      targets: ["AppRoot"]),
    .library(
      name: "AppRootImpl",
      targets: ["AppRootImpl"]),
    .library(
      name: "Editor",
      targets: ["Editor"]),
    .library(
      name: "EditorImpl",
      targets: ["EditorImpl"]),
    .library(
      name: "LoggedIn",
      targets: ["LoggedIn"]),
    .library(
      name: "LoggedInImpl",
      targets: ["LoggedInImpl"]),
    .library(
      name: "LoggedOut",
      targets: ["LoggedOut"]),
    .library(
      name: "LoggedOutImpl",
      targets: ["LoggedOutImpl"]),
    .library(
      name: "Start",
      targets: ["Start"]),
    .library(
      name: "StartImpl",
      targets: ["StartImpl"]),
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../ProxyPackage")
  ],
  targets: [
    .target(
      name: "AppRoot",
      dependencies: [
        "ProxyPackage"
      ]),
    .target(
      name: "AppRootImpl",
      dependencies: [
        "AppRoot",
        "LoggedIn",
        "LoggedOut",
        .product(name: "AuthenticationUsecase", package: "Domain"),
        .product(name: "SharedUI", package: "ProxyPackage"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
      ]),
    .target(
      name: "Editor",
      dependencies: [
        "ProxyPackage"
      ]),
    .target(
      name: "EditorImpl",
      dependencies: [
        "Editor",
        .product(name: "BookmarkUsecase", package: "Domain"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
        .product(name: "SharedUI", package: "ProxyPackage"),
      ]),
    .target(
      name: "LoggedIn",
      dependencies: [
        "ProxyPackage"
      ]),
    .target(
      name: "LoggedInImpl",
      dependencies: [
        "LoggedIn",
        .product(name: "AuthenticationUsecase", package: "Domain"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
        .product(name: "SharedUI", package: "ProxyPackage"),
      ]),
    .target(
      name: "LoggedOut",
      dependencies: [
        "ProxyPackage"
      ]),
    .target(
      name: "LoggedOutImpl",
      dependencies: [
        "LoggedOut",
        .product(name: "AuthenticationUsecase", package: "Domain"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
        .product(name: "SharedUI", package: "ProxyPackage"),
      ]
    ),
    .target(
      name: "Start",
      dependencies: [
        "ProxyPackage"
      ]),
    .target(
      name: "StartImpl",
      dependencies: [
        "Start",
        "Editor",
        .product(name: "AuthenticationUsecase", package: "Domain"),
        .product(name: "AppFoundation", package: "ProxyPackage"),
        .product(name: "SharedUI", package: "ProxyPackage"),
      ]),
    .testTarget(
      name: "LoggedInImplTests",
      dependencies: ["LoggedIn"]),
    .testTarget(
      name: "LoggedOutImplTests",
      dependencies: ["LoggedOut"]),
    .testTarget(
      name: "StartImplTests",
      dependencies: [
        "StartImpl",
        .product(name: "RIBsTestSupport", package: "ProxyPackage")
      ]
    )
  ]
)
