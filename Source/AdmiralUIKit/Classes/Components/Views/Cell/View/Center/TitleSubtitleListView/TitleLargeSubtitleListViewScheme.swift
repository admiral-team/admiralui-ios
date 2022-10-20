//
//  TitleLargeSubtitleScheme.swift
//  AdmiralUI
//
//  Created on 26.02.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct TitleLargeSubtitleScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var titleColor = ControlParameter<AColor>()
    var subtitleColor = ControlParameter<AColor>()
    var additionaColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    var subtitleFont: AFont
    var additionalTitleFont: AFont
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        additionaColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        additionaColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subtitle2
        additionalTitleFont = theme.fonts.subhead3
    }
}
