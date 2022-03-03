//
//  CheckControlScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct CheckControlScheme {
    var normal = ControlParameter<AColor>()
    var error = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        normal.set(parameter: theme.colors.elementAccent, for: .normal)
        error.set(parameter: theme.colors.elementError, for: .normal)
        
        normal.set(parameter: theme.colors.elementAccentPressed, for: .highlighted)
        error.set(parameter: theme.colors.elementError, for: .highlighted)
        
        normal.set(parameter: theme.colors.elementAccentPressed, for: [.highlighted, .selected])
        error.set(parameter: theme.colors.elementError, for: [.highlighted, .selected])
        
        normal.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        error.set(parameter: theme.colors.elementError.withAlpha(alpha), for: .disabled)
        
        normal.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        error.set(parameter: theme.colors.elementError.withAlpha(alpha), for: [.disabled, .selected])
    }
}
