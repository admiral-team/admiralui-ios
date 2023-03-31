// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModuleUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ModuleUI",
            targets: ["ModuleUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/admiral-team/admiralui-ios.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ModuleUI",
            dependencies: [
                .product(name: "AdmiralUIKit", package: "admiralui-ios"),
                .product(name: "AdmiralSwiftUI", package: "admiralui-ios"),
                .product(name: "AdmiralUIResources", package: "admiralui-ios"),
                .product(name: "AdmiralCore", package: "admiralui-ios")
            ]),
        .testTarget(
            name: "ModuleUITests",
            dependencies: ["ModuleUI"]),
    ]
)
