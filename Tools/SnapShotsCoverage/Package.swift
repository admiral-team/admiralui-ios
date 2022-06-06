// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapShotsCoverage",
    products: [
        .executable(name: "snapShotsCoverage", targets: ["SnapShotsCoverage"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/SourceKitten", from: "0.27.0")
    ],
    targets: [
          .executableTarget(name: "SnapShotsCoverage", dependencies: [
              .product(name: "ArgumentParser", package: "swift-argument-parser"),
              .product(name: "SourceKittenFramework", package: "SourceKitten")
          ]),
      ]
)
