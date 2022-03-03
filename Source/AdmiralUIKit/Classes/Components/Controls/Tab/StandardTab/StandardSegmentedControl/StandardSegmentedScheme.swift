//
//  StandardSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct StandardSegmentedScheme {
    
    struct ItemScheme {
        var titleColor = ControlParameter<AColor>()
        var titleFont = ControlParameter<AFont>()
    }
    
    var itemScheme = ItemScheme()
    var borderColor = ControlParameter<AColor>()
    var thumbColor = ControlParameter<AColor>()
    
    init() {
        //
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        itemScheme.titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)

        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.disabled, .selected])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.disabled, .selected])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
    
}
