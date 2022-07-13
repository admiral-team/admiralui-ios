//
//  PlatformButtonAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created on 05.07.2022.
//

import Foundation

enum PlatformButtonAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case activityIndicator = "activityIndicator"
    case lable = "lable"
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + PlatformButtonAccessibilityIdentifiers.separator + self.rawValue
    }
    
}
