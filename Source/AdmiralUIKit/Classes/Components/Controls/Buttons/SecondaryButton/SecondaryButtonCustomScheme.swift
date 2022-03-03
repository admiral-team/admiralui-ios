//
//  SecondaryButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SecondaryButtonCustomScheme {
    
    var normalTextColor: AColor
    var hightlightedTextColor: AColor
    var disabledTextColor: AColor
    
    var backgroundColor: AColor
    var borderNormalColor: AColor
    var borderHightlightedColor: AColor
    var borderDisabledColor: AColor
    
    var titleLabelFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        
        normalTextColor = theme.colors.textAccent
        hightlightedTextColor = theme.colors.textAccentPressed
        disabledTextColor = theme.colors.textAccent.withAlpha(alpha)
        
        borderNormalColor = theme.colors.backgroundAccent
        borderHightlightedColor = theme.colors.backgroundAccentPressed
        borderDisabledColor = theme.colors.backgroundAccent.withAlpha(alpha)
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
