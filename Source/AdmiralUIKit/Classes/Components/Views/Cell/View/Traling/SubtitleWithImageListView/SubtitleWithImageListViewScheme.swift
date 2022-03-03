//
//  SubtitleWithImageListViewScheme.swift
//  AdmiralUI
//
//  Created on 04.03.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct SubtitleWithImageListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var imageTintColor = ControlParameter<AColor>()
    var subtitleLabelTextColor = ControlParameter<AColor>()
    
    var subtitleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        subtitleFont = theme.fonts.subhead3
    }
}
