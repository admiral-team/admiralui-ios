//
//  InputRangeTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct InputRangeTextFieldScheme {
    var slider: SliderScheme
    var textField: TextFieldScheme
    var valueFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        self.valueFont = theme.fonts.subhead3
        self.textField = TextFieldScheme(theme: theme)
        self.slider = SliderScheme(theme: theme)
    }
}
