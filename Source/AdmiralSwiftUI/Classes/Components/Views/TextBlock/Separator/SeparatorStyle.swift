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
    /// This style install long width for separator.
    case long
    /// This style install short width for separator.
    case short
    /// This style install empty width for separator.
    case empty

    // MARK: - Computed Properties

    public var textBlockStyle: TextBlockStyle {
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
