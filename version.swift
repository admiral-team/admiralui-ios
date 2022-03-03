//
//  Versions.swift
//  AdmiralUI
//
//  Created on 08.12.2021.
//

import Foundation

public struct Version: Codable {

    public let internal_version: String
    public let external_version: String

    public var versionName: String {
        return "\(external_version) (\(internal_version))"
    }

    enum CodingKeys: String, CodingKey {
        case internal_version = "internal_version"
        case external_version = "external_version"
    }

}


public final class LibraryInfo {

    public static var version: Version? {
        loadJson(with: "version.json")
    }

}

private final class BundleJson {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleJson.self)
    #endif
  }()
}

private extension LibraryInfo {

    private static func loadJson<T: Decodable>(with fileName: String) -> T? {
        guard let url = BundleJson.bundle.url(forAuxiliaryExecutable: fileName) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}

