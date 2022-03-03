//
//  UnderlineSliderScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct UnderlineSliderScheme {
    
    struct ItemScheme {
        var titleFont = ControlParameter<AFont>()
        var titleColor = ControlParameter<AColor>()
    }
    
    var itemScheme = ItemScheme()
    var thumbColor = ControlParameter<AColor>()
    
    init() {
        //
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleFont.set(parameter: theme.fonts.body2, for: .normal)
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: .selected)
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.normal, .selected])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.normal, .highlighted])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.selected, .highlighted])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
    }
    
}
