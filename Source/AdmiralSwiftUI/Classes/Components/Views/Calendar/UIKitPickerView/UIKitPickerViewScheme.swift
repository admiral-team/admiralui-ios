//
//  PickerViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 14.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PickerViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var titleColor: AColor
    
    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
    
}

