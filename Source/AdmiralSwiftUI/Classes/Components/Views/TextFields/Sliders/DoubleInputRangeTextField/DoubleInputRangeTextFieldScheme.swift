//
//  DoubleInputRangeTextFieldScheme.swift
//  AdmiralSwiftUI
//
//  Created on 29.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct DoubleInputRangeTextFieldScheme: AppThemeScheme {
    public var slider: SliderScheme
    public var textField: StandardTextFieldScheme
    public var valueFont: AFont
    
    public var textFont: AFont
    public var textColor: AColor

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        self.valueFont = theme.fonts.subhead3
        self.textField = StandardTextFieldScheme(theme: theme)
        self.slider = SliderScheme(theme: theme)
        
        self.textFont = theme.fonts.body1
        self.textColor = theme.colors.textSecondary
    }
}
