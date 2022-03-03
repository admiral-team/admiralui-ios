//
//  ZeroScreenViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 05.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ZeroScreenViewScheme: AppThemeScheme {
    
    public var titleColor: AColor
    public var titleFont: AFont
    
    public var subtitleColor: AColor
    public var subtitleFont: AFont
    
    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.title1
        
        subtitleColor = theme.colors.textSecondary
        subtitleFont = theme.fonts.body2
    }
}
