//
//  TextMessageListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TextMessageListViewScheme {
    
    var messageTitleLabelTitleColor = ControlParameter<AColor>()
    var messageViewBackgroundColor = ControlParameter<AColor>()
    var viewBackgroundColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        viewBackgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        viewBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        messageTitleLabelTitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        messageTitleLabelTitleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        messageViewBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        titleFont = theme.fonts.subhead4
    }
}
