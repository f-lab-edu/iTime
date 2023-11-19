// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ProxyPackage",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "ProxyPackage",
      targets: ["ProxyPackage"]),
    .library(
      name: "AppFoundation",
      targets: ["AppFoundation"]),
    .library(
      name: "SharedUI",
      targets: ["SharedUI"]),
    .library(
      name: "RIBsTestSupport",
      targets: ["RIBsTestSupport"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.15.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: "6.2.0"),
    .package(url: "https://github.com/uber/RIBs.git", exact: "0.14.1"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", from: "4.0.4"),
    .package(url: "https://github.com/richardtop/CalendarKit.git", branch: "master"),
  ],
  targets: [
    .target(
      name: "ProxyPackage",
      dependencies: [
        .product(name: "SnapKit", package: "SnapKit"),
        .product(name: "RxGesture", package: "RxGesture"),
        .product(name: "RIBs", package: "RIBs"),
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "RxCocoa", package: "RxSwift"),
        .product(name: "RxRelay", package: "RxSwift"),
        .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
        .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
        .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
        .product(name: "CalendarKit", package: "CalendarKit"),
      ]
    ),
    .target(
      name: "RIBsTestSupport",
      dependencies: [
        "ProxyPackage"
      ]
    ),
    .target(
      name: "AppFoundation",
      dependencies: [
        "ProxyPackage"
      ]
    ),
    .target(
      name: "SharedUI",
      dependencies: [
        "ProxyPackage",
        "AppFoundation"
      ],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "ProxyPackageTests",
      dependencies: [
        "ProxyPackage"
      ]
    ),
  ]
)
