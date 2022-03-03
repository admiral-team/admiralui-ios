//
//  TitleWithArrowListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TitleWithArrowListViewScheme {
    
    var viewBackgroundColor = ControlParameter<AColor>()
    var titleLabelTextColor = ControlParameter<AColor>()
    var arrowImageTintColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        viewBackgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        viewBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleLabelTextColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        arrowImageTintColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
        arrowImageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.title1
    }
}
