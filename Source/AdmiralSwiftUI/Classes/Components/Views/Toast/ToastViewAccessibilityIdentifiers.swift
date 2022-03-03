//
//  ToastViewAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created on 25.01.2022.
//

import Foundation

enum ToastViewAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case imageView = "imageView"
    case linkText = "linkText"
    case closeButton = "closeButton"
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + ToastViewAccessibilityIdentifiers.separator + self.rawValue
    }
    
}
