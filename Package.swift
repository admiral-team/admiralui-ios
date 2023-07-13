// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let main = Package(
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
            name: "AdmiralImages",
            targets: ["AdmiralImages"]),
        .library(
            name: "AdmiralSymbols",
            targets: ["AdmiralSymbols"]),
        .library(
            name: "AdmiralCore",
            targets: ["AdmiralCore"]),
        .library(
            name: "AdmiralCalendarSwiftUI",
            targets: ["AdmiralCalendarSwiftUI"]),
    ],
    targets: [
        .target(
            name: "AdmiralUIKit",
            dependencies: ["AdmiralTheme", "AdmiralCore"],
            path: "Source/AdmiralUIKit/",
            exclude: ["Supporting Files"],
            resources: [
                .process("Resources/Assets/")
            ]),
        .target(
            name: "AdmiralSwiftUI",
            dependencies: ["AdmiralTheme", "AdmiralCore"],
            path: "Source/AdmiralSwiftUI/",
            exclude: ["Supporting Files"],
            resources: [
                .process("Resources/Assets/")
            ]),
        .target(
            name: "AdmiralTheme",
            dependencies: [],
            path: "Source/AdmiralTheme/",
            exclude: ["Supporting Files"],
            resources: [
                .process("Resources/Fonts/")
            ]),
        .target(
            name: "AdmiralImages",
            dependencies: [],
            path: "Source/AdmiralImages/",
            exclude: ["Supporting Files"],
            resources: [
                .process("Resources/Assets/"),
            ]),
        .target(
            name: "AdmiralSymbols",
            dependencies: [],
            path: "Source/AdmiralSymbols/",
            resources: [
                .process("Resources/Assets/")
            ]),
        .target(
            name: "AdmiralCalendarSwiftUI",
            dependencies: ["AdmiralTheme", "AdmiralCore"],
            path: "Source/AdmiralCalendarSwiftUI/",
            resources: [
                .process("Resources/Assets/")
            ]),
        .target(
            name: "AdmiralCore",
            dependencies: [],
            path: "Source/AdmiralCore/"
        )
    ]
)
