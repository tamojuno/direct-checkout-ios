// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DirectCheckout",
    products: [
        .library(name: "DirectCheckout", targets: ["DirectCheckout"]),
    ],
    targets: [
        .target(name: "DirectCheckout", path: "DirectCheckout"),
//        .testTarget(name: "direct-checkout-iosTests", dependencies: ["direct-checkout-ios"]),
    ]
)
