//
//  TitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TitleListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var textColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        titleFont = theme.fonts.body1
    }
}
