//
//  ButtonsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI

@available(iOS 14.0, *)
enum ButtonsSwiftUIItem: Int, CaseIterable {
    case primaryButtons
    case secondaryButtons
    case ghostButtons
    case rules
    case otherButtons
    
    var title: String {
        switch self {
        case .primaryButtons:
            return "Primary buttons"
        case .secondaryButtons:
            return "Secondary buttons"
        case .ghostButtons:
            return "Ghost buttons"
        case .rules:
            return "Rules"
        case .otherButtons:
            return "Other buttons"
        }
    }
}
