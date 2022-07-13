//
//  PlatformButtonCustomScheme.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct PlatformButtonCustomScheme {
    
    let titleLabelFont: AFont
    var buttonBackgroundColor = ControlParameter<AColor>()
    var backgroundLayerColor: AColor
    var textColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        let highlightedOpacity: CGFloat = 0.8
        
        titleLabelFont = theme.fonts.body1
        
        backgroundLayerColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(highlightedOpacity), for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        textColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }
    
}
