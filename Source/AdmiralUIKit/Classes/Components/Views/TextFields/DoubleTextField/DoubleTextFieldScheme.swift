//
//  DoubleTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct DoubleTextFieldScheme {
    var first: TextFieldScheme
    var second: TextFieldScheme
    
    var errorColor: AColor
    var underlineColor: AColor
    var disabledColor: AColor
    
    var informerFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        self.informerFont = theme.fonts.subhead3
    
        self.first = TextFieldScheme(theme: theme)
        self.second = TextFieldScheme(theme: theme)
        
        self.errorColor = theme.colors.textError
        self.underlineColor = theme.colors.textSecondary
        self.disabledColor = theme.colors.textSecondary.withAlpha(alpha)
    }
}
