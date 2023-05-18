//
//  Codable+Dictionary.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError(domain: "unknown", code: 0)
        }
        return dictionary
    }
    
}
