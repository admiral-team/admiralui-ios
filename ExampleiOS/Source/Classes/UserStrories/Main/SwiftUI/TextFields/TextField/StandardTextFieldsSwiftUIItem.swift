//
//  StandardTextFieldsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 14.05.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum StandardTextFieldsSwiftUIItem: Int, CaseIterable {
    case standard
    case cardNumber
    case smsCode
    
    var title: String {
        switch self {
        case .standard:
            return "Standard"
        case .cardNumber:
            return "Card Number"
        case .smsCode:
            return "SMS Code"
        }
    }
}
