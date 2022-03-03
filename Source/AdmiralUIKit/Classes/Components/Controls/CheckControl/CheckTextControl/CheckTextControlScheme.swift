//
//  CheckTextControlScheme.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct CheckTextControlScheme {
    
    var textColor = ControlParameter<AColor>()
    var checkControlScheme = CheckControlScheme()
    
    var textFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled, .selected])
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled, .normal])
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled])
        checkControlScheme = CheckControlScheme(theme: theme)
        textFont = theme.fonts.subhead4
    }
    
}
