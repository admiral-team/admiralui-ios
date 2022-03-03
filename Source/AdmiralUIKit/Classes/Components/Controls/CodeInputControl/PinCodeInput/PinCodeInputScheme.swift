//
//  PinCodeInputScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct PinCodeInputScheme {
    var defaultColor: AColor
    var activeColor: AColor
    var successColor: AColor
    var errorColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        defaultColor = theme.colors.elementAdditional
        activeColor = theme.colors.elementAccent
        successColor = theme.colors.elementSuccess
        errorColor = theme.colors.elementError
    }
}
