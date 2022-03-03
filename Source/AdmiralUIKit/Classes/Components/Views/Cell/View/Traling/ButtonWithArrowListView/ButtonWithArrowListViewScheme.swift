//
//  ButtonWithArrowListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct ButtonWithArrowListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    
    var buttonTextColor = ControlParameter<AColor>()
    var buttonBackgroundColor = ControlParameter<AColor>()
    
    var arrowImageTintColor = ControlParameter<AColor>()
    
    var buttonFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        buttonTextColor.set(parameter: theme.colors.textAccent, for: .normal)
        buttonTextColor.set(parameter: theme.colors.textAccentPressed, for: .selected)
        buttonTextColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        buttonTextColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
        
        buttonBackgroundColor.set(parameter: .clear, for: .normal)
        buttonBackgroundColor.set(parameter: .clear, for: .highlighted)
        buttonBackgroundColor.set(parameter: .clear, for: .selected)
        
        arrowImageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        arrowImageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        buttonFont = theme.fonts.body1
    }
}
