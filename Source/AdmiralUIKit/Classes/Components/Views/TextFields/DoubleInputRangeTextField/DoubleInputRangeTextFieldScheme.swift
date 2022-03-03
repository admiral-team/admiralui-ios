//
//  DoubleInputRangeTextFieldScheme.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct DoubleInputRangeTextFieldScheme {
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
