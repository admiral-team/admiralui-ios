//
//  RadioButtonListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct RadioButtonListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var radioButtonViewTintColor = ControlParameter<AColor>()
    
    var radioButtonScheme = CheckTextControlScheme()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        radioButtonViewTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        radioButtonViewTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        radioButtonScheme = CheckTextControlScheme(theme: theme)
    }
}
