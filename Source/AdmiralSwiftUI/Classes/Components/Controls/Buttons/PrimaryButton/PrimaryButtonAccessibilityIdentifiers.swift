//
//  PrimaryButtonAccessibilityIdentifiers.swift
//  AdmiralSwiftUI
//
//  Created on 08.02.2022.
//

import Foundation

enum PrimaryButtonAccessibilityIdentifiers: String {
    
    static let separator = "."
    
    case activityIndicator = "activityIndicator"
    case lable = "lable"
    
    func accessibilityViewIdentifier(accessibilityIdentifier: String?) -> String {
        guard let accessibilityIdentifier = accessibilityIdentifier else { return "" }
        return accessibilityIdentifier + PrimaryButtonAccessibilityIdentifiers.separator + self.rawValue
    }
    
}
