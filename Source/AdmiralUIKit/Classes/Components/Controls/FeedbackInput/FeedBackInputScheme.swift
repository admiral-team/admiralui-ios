//
//  FeedBackInputScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct FeedBackInputScheme {
    var defaultColor = ControlParameter<AColor>()
    var selectedColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        defaultColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        selectedColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        defaultColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        selectedColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
