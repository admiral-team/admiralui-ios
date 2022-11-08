//
//  SubtitleTitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct SubtitleTitleListViewScheme {
    
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
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subhead4
    }
}
