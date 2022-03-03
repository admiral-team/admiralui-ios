//
//  CountdownViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 07.10.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ClockScheme: AppThemeScheme {
    
    public var textColor: AColor
    public var textFont: AFont
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textAccent
        textFont = theme.fonts.subhead3
    }
}

public struct ProgressBarScheme: AppThemeScheme {
    
    public var tintColor: AColor
    
    public init(theme: AppTheme) {
        tintColor = theme.colors.elementAccent
    }
}
