//
//  TwoTitleGhostButtonScheme.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TwoTitleGhostButtonScheme {
    
    var leftTitleColor = ControlParameter<AColor>()
    var rightTitleColor = ControlParameter<AColor>()
    var backgroundColor: AColor

    var leftLabelFont: AFont
    var rightLabelFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        leftLabelFont = theme.fonts.subhead3
        rightLabelFont = theme.fonts.body1
        
        backgroundColor = theme.colors.backgroundBasic
        
        leftTitleColor.set(parameter: theme.colors.textAccent, for: [.normal])
        leftTitleColor.set(parameter: theme.colors.textAccentPressed, for: [.highlighted])
        leftTitleColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.disabled])
        
        rightTitleColor.set(parameter: theme.colors.textAccent, for: [.normal])
        rightTitleColor.set(parameter: theme.colors.textAccentPressed, for: [.highlighted])
        rightTitleColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.disabled])

    }
    
}
