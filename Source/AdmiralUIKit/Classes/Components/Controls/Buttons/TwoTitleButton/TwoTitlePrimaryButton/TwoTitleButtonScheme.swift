//
//  TwoTitleButtonScheme.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TwoTitleButtonScheme {
    
    var leftTitleColor = ControlParameter<AColor>()
    var rightTitleColor = ControlParameter<AColor>()
    var backgroundColor = ControlParameter<AColor>()
    var backBackgroundColor: AColor

    var leftLabelFont: AFont
    var rightLabelFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        leftLabelFont = theme.fonts.subhead3
        rightLabelFont = theme.fonts.body1
        
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        
        leftTitleColor.set(parameter: theme.colors.textStaticWhite, for: [.normal])
        leftTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: [.disabled])
        
        rightTitleColor.set(parameter: theme.colors.textStaticWhite, for: [.normal])
        rightTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: [.disabled])
        
        backBackgroundColor = theme.colors.backgroundBasic
    }
    
}
