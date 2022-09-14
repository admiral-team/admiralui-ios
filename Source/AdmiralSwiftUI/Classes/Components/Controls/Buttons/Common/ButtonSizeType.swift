//
//  ButtonSizeType.swift
//  AdmiralSwiftUI
//
//  Created on 03.10.2021.
//

import SwiftUI

/// The button size type
public enum ButtonSizeType: String {

    /// The small size
    case small

    /// The medium size
    case medium

    /// The big size
    case big

    // MARK: - Computed Properties

    var height: CGFloat {
        switch self {
        case .small:
            return LayoutGrid.halfModule * 10
        case .medium:
            return LayoutGrid.doubleModule * 3
        case .big:
            return LayoutGrid.doubleModule * 3
        }
    }

    var width: CGFloat? {
        switch self {
        case .small:
            return LayoutGrid.module * 16
        case .medium:
            return LayoutGrid.halfModule * 75
        case .big:
            return nil
        }
    }
}
