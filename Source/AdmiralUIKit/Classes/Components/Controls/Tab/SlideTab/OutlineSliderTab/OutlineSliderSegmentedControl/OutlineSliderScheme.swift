//
//  OutlineSliderScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct OutlineSliderScheme {
            
    struct ItemScheme {
        var titleFont = ControlParameter<AFont>()
        var titleColor = ControlParameter<AColor>()
    }
    
    var itemScheme = ItemScheme()
    var borderColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.normal, .selected])
        borderColor.set(parameter: theme.colors.elementAccent, for: [.normal, .selected])
        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        borderColor.set(parameter: theme.colors.elementAccent, for: .selected)

        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.selected, .highlighted])
        borderColor.set(parameter: theme.colors.elementAccent, for: [.selected, .highlighted])

        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.selected, .disabled])
        borderColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
    }
    
}
