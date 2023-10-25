// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProxyPackage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ProxyPackage",
            targets: ["ProxyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.15.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", exact: "5.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: "6.2.0"),
        .package(url: "https://github.com/uber/needle.git", exact: "0.23.0"),
        .package(url: "https://github.com/uber/RIBs.git", exact: "0.14.1"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", from: "4.0.4")
    ],
    targets: [
        .target(
            name: "ProxyPackage",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "RxGesture", package: "RxGesture"),
                .product(name: "ReactorKit", package: "ReactorKit"),
                .product(name: "RIBs", package: "RIBs"),
                .product(name: "RxDataSources", package: "RxDataSources"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxRelay", package: "RxSwift"),
                .product(name: "NeedleFoundation", package: "needle"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
            ]),
        .testTarget(
            name: "ProxyPackageTests",
            dependencies: ["ProxyPackage"]),
    ]
)
