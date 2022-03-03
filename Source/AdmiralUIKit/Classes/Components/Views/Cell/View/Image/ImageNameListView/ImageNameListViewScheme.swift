//
//  ImageNameListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct ImageNameListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var backgroundNameViewColor = ControlParameter<AColor>()
    var titleLabelTextColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
        
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary, for: .normal)
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary.withAlpha(alpha), for: .disabled)
        titleFont = theme.fonts.subhead1
    }
}
