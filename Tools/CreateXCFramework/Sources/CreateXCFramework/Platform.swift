//
//  File.swift
//  
//
//  Created by Борисов Кирилл Анатольевич on 03.03.2023.
//

import Foundation

struct Platform {
    let name: String
    let destination: String
    let sdk: String
    let archs: String
    let supportsBitcode: Bool
    let buildFolder: String
}

extension Platform {

    static let ios = Platform(
        name: "ios",
        destination: "-destination generic/platform=iOS",
        sdk: "iphoneos",
        archs: "arm64",
        supportsBitcode: true,
        buildFolder: "Release-iphoneos"
    )

    static let simulator = Platform(
        name: "simulator",
        destination: "-destination 'generic/platform=iOS Simulator'",
        sdk: "iphonesimulator",
        archs: "x86_64 arm64",
        supportsBitcode: false,
        buildFolder: "Release-iphonesimulator"
    )

}
