// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdmiralUI",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "AdmiralUIKit",
            targets: ["AdmiralUIKit"]),
        .library(
            name: "AdmiralSwiftUI",
            targets: ["AdmiralSwiftUI"]),
        .library(
            name: "AdmiralTheme",
            targets: ["AdmiralTheme"]),
        .library(
            name: "AdmiralUIResources",
            targets: ["AdmiralUIResources"]),
        .library(
                name: "AdmiralCore",
                targets: ["AdmiralCore"]),
        .library(
                name: "AdmiralAssets",
                targets: ["AdmiralAssets"]),
    ],
    targets: [
        .target(
            name: "AdmiralUIKit",
            dependencies: ["AdmiralTheme", "AdmiralUIResources", "AdmiralCore"],
            path: "Source/AdmiralUIKit",
            exclude: ["Supporting Files"]),
        .target(
            name: "AdmiralSwiftUI",
            dependencies: ["AdmiralTheme", "AdmiralUIResources", "AdmiralCore"],
            path: "Source/AdmiralSwiftUI",
            exclude: ["Supporting Files"]),
        .target(
            name: "AdmiralTheme",
            dependencies: ["AdmiralUIResources"],
            path: "Source/AdmiralTheme",
            exclude: ["Supporting Files"]),
        .target(
            name: "AdmiralUIResources",
            dependencies: [],
            path: "Source/AdmiralUIResources",
            exclude: ["Supporting Files"],
            resources: [
                .process("Resources/Assets"),
                .process("Resources/Fonts")
            ]),
        .target(
                name: "AdmiralCore",
                dependencies: [],
                path: "Source/AdmiralCore",
                exclude: ["Supporting Files"]),
        .target(
                name: "AdmiralAssets",
                dependencies: [],
                path: "Source/AdmiralAssets",
                exclude: ["Supporting Files"]),
    ]
)
