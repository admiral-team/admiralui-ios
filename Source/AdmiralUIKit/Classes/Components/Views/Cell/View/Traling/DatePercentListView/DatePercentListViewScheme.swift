//
//  DatePercentListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct DatePercentListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var titleColor = ControlParameter<AColor>()
    var subtitleColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    var subtitleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.subhead3
        subtitleFont = theme.fonts.subhead3
    }
}
