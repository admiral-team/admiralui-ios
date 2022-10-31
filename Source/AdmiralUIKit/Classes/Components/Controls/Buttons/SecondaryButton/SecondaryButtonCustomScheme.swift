//
//  SecondaryButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 SecondaryButtonCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SecondaryButtonCustomScheme() - Initialize default SecondaryButtonCustomScheme with default themezation
Example to create SecondaryButtonCustomScheme:
Code
 ```
let scheme = SecondaryButtonCustomScheme()
 ```
 */
public struct SecondaryButtonCustomScheme {

    /// Normal text color.
    public var normalTextColor: AColor

    /// Hightlighted text color.
    public var hightlightedTextColor: AColor

    /// Disabled text color.
    public var disabledTextColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    /// Border normal color.
    public var borderNormalColor: AColor

    /// Border hightlighted color.
    public var borderHightlightedColor: AColor

    /// Border disabled color.
    public var borderDisabledColor: AColor

    /// Title label font.
    public var titleLabelFont: AFont
    
    public init(theme: AppTheme = .default) {
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
