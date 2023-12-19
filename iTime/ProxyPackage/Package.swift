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
      name: "BaseRepository",
      targets: ["BaseRepository"]),
    .library(
      name: "SharedUI",
      targets: ["SharedUI"]),
    .library(
      name: "ProxyTestSupport",
      targets: ["ProxyTestSupport"]),
    .library(
      name: "RIBsTestSupport",
      targets: ["RIBsTestSupport"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.15.0"),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: "6.5.0"),
    .package(url: "https://github.com/uber/RIBs.git", exact: "0.15.1"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", from: "4.0.4"),
    .package(url: "https://github.com/richardtop/CalendarKit.git", branch: "master"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.9.0"),
    .package(url: "https://github.com/pointfreeco/swift-clocks", from: "1.0.2"),
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
        .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
        .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
        .product(name: "CalendarKit", package: "CalendarKit"),
        .product(name: "Clocks", package: "swift-clocks"),
      ]
    ),
    .target(
      name: "RIBsTestSupport",
      dependencies: [
        "ProxyPackage"
      ]
    ),
    .target(
      name: "ProxyTestSupport",
      dependencies: [
        .product(name: "RxTest", package: "RxSwift"),
        .product(name: "RxBlocking", package: "RxSwift"),
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
    .target(
      name: "AppFoundation",
      dependencies: [
        "ProxyPackage"
      ]
    ),
    .target(
      name: "BaseRepository",
      dependencies: [
        "ProxyPackage",
      ]),
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
