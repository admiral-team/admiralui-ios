//
//  InputRangeTextFieldScheme.swift
//  AdmiralSwiftUI
//
//  Created on 27.05.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct InputRangeTextFieldScheme: AppThemeScheme {
    public var slider: SliderScheme
    public var textField: StandardTextFieldScheme
    public var valueFont: AFont

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        self.valueFont = theme.fonts.subhead3
        self.textField = StandardTextFieldScheme(theme: theme)
        self.slider = SliderScheme(theme: theme)
    }
}
