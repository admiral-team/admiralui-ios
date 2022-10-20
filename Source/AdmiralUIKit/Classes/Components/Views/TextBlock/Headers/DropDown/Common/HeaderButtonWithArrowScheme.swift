//
//  HeaderButtonWithArrowScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

/**
 HeaderButtonWithArrowScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - HeaderButtonWithArrowScheme() - Initialize default HeaderButtonWithArrowScheme with default themezation
Example to create HeaderButtonWithArrowScheme:
Code
 ```
let scheme = HeaderButtonWithArrowScheme()
 ```
 */
public struct HeaderButtonWithArrowScheme {

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    /// Title label font.
    public var titleLabelFont: AFont

    /// Image tint color.
    public var imageColor = ControlParameter<AColor>()

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: [.normal])
        textColor.set(parameter: theme.colors.textAccentPressed, for: [.highlighted])
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.disabled])
        
        imageColor.set(parameter: theme.colors.elementAccent, for: [.normal])
        imageColor.set(parameter: theme.colors.elementAccentPressed, for: [.highlighted])
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled])
        
    }
    
}

