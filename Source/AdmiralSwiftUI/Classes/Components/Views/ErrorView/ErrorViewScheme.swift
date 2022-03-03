//
//  ErrorViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ErrorViewScheme: AppThemeScheme {
    
    public var titleColor: AColor
    public var titleFont: AFont
    
    public init(theme: AppTheme) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
    }
}
