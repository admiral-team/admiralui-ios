//
//  ButtonSizeType.swift
//  AdmiralSwiftUI
//
//  Created on 03.10.2021.
//

import SwiftUI

public enum ButtonSizeType: String {
    case small
    case medium
    case big
    
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
