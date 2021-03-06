//
//  PaddingStyle.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import Foundation

/**
 SeparatorStyle - Public enum for SeparatorView
 
 SeparatorStyle can be one of the following values:
 - long
 - short
 - empty
 */
@available(iOS 14.0, *)
public enum SeparatorStyle: String {
    case long
    case short
    case empty
    
    var textBlockStyle: TextBlockStyle {
        switch self {
        case .long:
            return .separator
        case .short:
            return .separatorShort
        case .empty:
            return .separatorEmpty
        }
    }
}
