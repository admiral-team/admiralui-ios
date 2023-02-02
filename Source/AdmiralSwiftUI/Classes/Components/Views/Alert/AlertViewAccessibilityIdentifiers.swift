//
//  AlertViewAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created by on 26.01.2023.
//  
//


import Foundation

enum AlertViewAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case mainButton
    case additionalButton
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + AlertViewAccessibilityIdentifiers.separator + self.rawValue
    }
}
