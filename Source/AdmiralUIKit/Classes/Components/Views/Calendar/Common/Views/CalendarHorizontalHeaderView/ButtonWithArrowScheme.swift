//
//  ButtonWithArrowScheme.swift
//  AdmiralUIKit
//
//  Created on 10.11.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ButtonWithArrowScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ButtonWithArrowScheme() - Initialize default ButtonWithArrowScheme with default themezation
Example to create ButtonWithArrowScheme:
Code
 ```
let scheme = ButtonWithArrowScheme()
 ```
 */
public struct ButtonWithArrowScheme: AppThemeScheme {

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    /// Title label font.
    public var titleLabelFont: AFont

    /// Image color.
    public var imageColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.subtitle1
        
        textColor.set(parameter: theme.colors.textAccent, for: [.normal])
        textColor.set(parameter: theme.colors.textAccentPressed, for: [.highlighted])
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.disabled])
        
        imageColor.set(parameter: theme.colors.elementAccent, for: [.normal])
        imageColor.set(parameter: theme.colors.elementAccentPressed, for: [.highlighted])
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled])
        
    }
    
}
