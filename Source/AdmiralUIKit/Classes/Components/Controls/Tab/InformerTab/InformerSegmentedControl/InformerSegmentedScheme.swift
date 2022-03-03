//
//  InformerSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct InformerSegmentedScheme {
    
    struct ItemScheme {
        var titleFont: AFont = AppTheme.default.fonts.subtitle1
        var subtitleFont: AFont = AppTheme.default.fonts.subhead4
        
        var titleColor = ControlParameter<AColor>()
        var subtitleColor = ControlParameter<AColor>()
        
        var borderColor = ControlParameter<AColor>()
    }
    
    var itemScheme = ItemScheme()

    
    init() {
        //
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleFont = theme.fonts.subtitle1
        itemScheme.subtitleFont = theme.fonts.subhead4
        
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        
        itemScheme.borderColor.set(parameter: theme.colors.elementAccent, for: [.selected, .normal])
        itemScheme.borderColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: [.selected, .disabled])
    }
    
}
