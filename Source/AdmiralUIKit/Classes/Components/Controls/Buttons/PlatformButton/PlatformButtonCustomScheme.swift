//
//  PlatformButtonCustomScheme.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 PlatformButtonCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PlatformButtonCustomScheme() - Initialize default PlatformButtonCustomScheme with default themezation
Example to create PlatformButtonCustomScheme:
Code
 ```
let scheme = PlatformButtonCustomScheme()
 ```
 */
public struct PlatformButtonCustomScheme: AppThemeScheme {

    /// Title label font.
    public var titleLabelFont: AFont

    /// Button background color.
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// Background layer color.
    public var backgroundLayerColor: AColor

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        let highlightedOpacity: CGFloat = 0.8
        
        titleLabelFont = theme.fonts.body1
        
        backgroundLayerColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(highlightedOpacity), for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        textColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        textColor.set(parameter: theme.colors.backgroundBasic.withAlpha(alpha), for: .disabled)
    }
    
}
