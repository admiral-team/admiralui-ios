//
//  TextFieldsAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created on 16.01.2022.
//

import Foundation

enum TextFieldsAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case info = "info"
    case name = "name"
    case placeholder = "placeholder"
    case trailingView = "trailingView"
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + TextFieldsAccessibilityIdentifiers.separator + self.rawValue
    }
    
}
