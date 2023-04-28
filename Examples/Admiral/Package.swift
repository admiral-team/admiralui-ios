// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Admiral",
    platforms: [
        .iOS(.v13) //, .macCatalyst(.v15), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Admiral",
            targets: [
                "Admiral"
            ]
        ),
    ],
    targets: [
        .target(
            name: "Admiral",
            dependencies: ["AdmiralUIResources", "AdmiralCore", "AdmiralTheme", "AdmiralSwiftUI", "AdmiralUIKit"]
        ),
        .binaryTarget(
            name: "AdmiralSwiftUI",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.3.0/AdmiralSwiftUI.zip",
            checksum: "d9878da168a98fb49349b03dd5df51bee58d298d4502a7f76a42d9aba3a65fdc"
        ),
        .binaryTarget(
            name: "AdmiralTheme",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.3.0/AdmiralTheme.zip",
            checksum: "7220c87fffcbbda6d50a3c530c5365bd0d8749db0f42a31fcdc960052c27bd22"
        ),
        .binaryTarget(
            name: "AdmiralUIResources",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.3.0/AdmiralUIResources.zip",
            checksum: "a2fdfc0d78ceee0fc5bad23db72a6cf1d574de33e1e2d6c84ed85a82c966b4ed"
        ),
        .binaryTarget(
            name: "AdmiralUIKit",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.3.0/AdmiralUIKit.zip",
            checksum: "60d65fe6a4cacd8f38ace09fab6ed7048b01cc26b554c7d08c6a754c79bf46e6"
        ),
        .binaryTarget(
            name: "AdmiralCore",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.3.0/AdmiralCore.zip",
            checksum: "be52833648a9cb5dd0cac0fb17b489799cd1f2fe69537e64b2ec7d645c30e290"
        )
    ]
)
