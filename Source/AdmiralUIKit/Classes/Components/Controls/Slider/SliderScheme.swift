//
//  SliderScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct SliderScheme {
    var tintColor = ControlParameter<AColor>()
    var thumbColor = ControlParameter<AColor>()
    var thumbBorderColor = ControlParameter<AColor>()
    var backgroundColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        tintColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        thumbBorderColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        
        tintColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .disabled)
        backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        thumbBorderColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
    }
}
