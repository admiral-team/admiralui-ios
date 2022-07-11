//
//  PlatformButtonScheme.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct PlatformButtonScheme: AppThemeScheme {
    
    let font: AFont
    var backgroundColor: AColor
    var buttonBackgroundColor = ControlParameter<AColor>()
    var textColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        let highlightedOpacity: CGFloat = 0.8
        
        font = theme.fonts.body1
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(highlightedOpacity), for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        textColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }
    
}
