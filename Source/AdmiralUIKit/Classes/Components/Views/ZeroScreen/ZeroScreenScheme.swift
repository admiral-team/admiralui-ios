//
//  ZeroScreenScheme.swift
//  AdmiralUIResources
//
//  Created on 16.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

public struct ZeroScreenScheme {
    public var backgroundColor: AColor
    
    public var titleColor: AColor
    public var titleFont: AFont
    
    public var subtitleColor: AColor
    public var subtitleFont: AFont
    
    public var primaryButtonScheme: PrimaryButtonCustomScheme
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.title1
        
        subtitleColor = theme.colors.textSecondary
        subtitleFont = theme.fonts.body2
        
        primaryButtonScheme = PrimaryButtonCustomScheme(theme: theme)
    }
}
