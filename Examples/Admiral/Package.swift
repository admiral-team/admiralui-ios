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
            dependencies: ["AdmiralUIResources", "AdmiralCore", "AdmiralTheme", "AdmiralSwiftUI"]
        ),
        .binaryTarget(
            name: "AdmiralSwiftUI",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.2.2/AdmiralSwiftUI.zip",
            checksum: "5752ca59df61f5158bfaf76ee1d5ab0c6788b17c272b027567089b561db3e9e1"
        ),
        .binaryTarget(
            name: "AdmiralTheme",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.2.2/AdmiralTheme.zip",
            checksum: "96e87bb6510592541b977b1acc2f2450d8c1a32f609d381fc4c555428facd04d"
        ),
        .binaryTarget(
            name: "AdmiralUIResources",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.2.2/AdmiralUIResources.zip",
            checksum: "17c1598a732714617b9ae0bdd4a13cbbd0896853eb4d51628c38fa1a4f80152f"
        ),
        .binaryTarget(
            name: "AdmiralUIKit",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.2.2/AdmiralUIKit.zip",
            checksum: "1a5e691c53d8c61efa4030f1169f08eac164e05278b99cfe195998073d13b682"
        ),
        .binaryTarget(
            name: "AdmiralCore",
            url: "https://github.com/admiral-team/admiralui-ios/releases/download/11.2.2/AdmiralCore.zip",
            checksum: "9968b5fa4fa84eecb102ee04723d19bb1cddf3ec112fdbfffcb2c6d3e8b9a80f"
        )
    ]
)
