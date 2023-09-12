//
//  InputNumberAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created by on 30.01.2023.
//  
//


import Foundation

enum InputNumberAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case minus = "minus"
    case plus = "plus"
    case count = "count"
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + "." + self.rawValue
    }
    
}
