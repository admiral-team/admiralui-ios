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
            name: "AdmiralImages",
            targets: ["AdmiralImages"]),
        .library(
            name: "AdmiralSymbols",
            targets: ["AdmiralSymbols"]),
    ],
    targets: [
        .target(
            name: "AdmiralUIKit",
            dependencies: ["AdmiralTheme", "AdmiralUIResources"],
            path: "Source/AdmiralUIKit",
            exclude: ["Supporting Files"]),
        .target(
            name: "AdmiralSwiftUI",
            dependencies: ["AdmiralTheme", "AdmiralUIResources"],
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
                name: "AdmiralImages",
                dependencies: [],
                path: "Source/AdmiralImages",
                exclude: ["Supporting Files"],
                resources: [
                    .process("Resources/Assets"),
                ]),
        .target(
            name: "AdmiralSymbols",
            dependencies: [],
            path: "Source/AdmiralSymbols",
            resources: [
                .process("Resources/Assets")
            ])
    ]
)
