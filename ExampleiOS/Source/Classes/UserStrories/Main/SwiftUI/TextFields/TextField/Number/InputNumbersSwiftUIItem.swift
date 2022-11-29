//
//  InputNumbersSwiftUIItem.swift
//  ExampleiOS
//
//  Created by on 13.10.2022.
//  
//

import SwiftUI

@available(iOS 14.0, *)
enum InputNumbersSwiftUIItem: Int, CaseIterable {
    case `default`
    case secondary
    case input

    var title: String {
        switch self {
        case .default:
            return "Default"
        case .secondary:
            return "Secondary"
        case .input:
            return "Input"
        }
    }
}
