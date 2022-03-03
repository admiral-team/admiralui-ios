//
//  InputNumberScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct InputNumberScheme {
    var titleFont: AFont
    var numberFont: AFont
    
    var textColor = ControlParameter<AColor>()
    var tintColor = ControlParameter<AColor>()
    var backgroundColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleFont = theme.fonts.body1
        numberFont = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        tintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        tintColor.set(parameter: theme.colors.textSecondary, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        tintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
    }
}
