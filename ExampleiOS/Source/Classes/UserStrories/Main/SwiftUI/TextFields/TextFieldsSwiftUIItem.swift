//
//  TextFieldsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 13.05.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum TextFieldsSwiftUIItem: Int, CaseIterable {
    case standard
    case double
    case slider
    case number
    case feedback
    case pincode
    
    var title: String {
        switch self {
        case .standard:
            return "Standard"
        case .double:
            return "Double"
        case .slider:
            return "Slider"
        case .number:
            return "Number"
        case .feedback:
            return "Feedback"
        case .pincode:
            return "Pincode"
        }
    }
}
