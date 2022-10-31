//
//  TwoTitleButtonScheme.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 TwoTitleButtonScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TwoTitleButtonScheme() - Initialize default TwoTitleButtonScheme with default themezation
Example to create TwoTitleButtonScheme:
Code
 ```
let scheme = TwoTitleButtonScheme()
 ```
 */
public struct TwoTitleButtonScheme: AppThemeScheme {

    /// Left title color.
    public var leftTitleColor = ControlParameter<AColor>()

    /// Right title color.
    public var rightTitleColor = ControlParameter<AColor>()

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Back background color.
    public var backBackgroundColor: AColor

    /// Left label font.
    public var leftLabelFont: AFont

    /// Right label font.
    public var rightLabelFont: AFont
    
    public init(theme: AppTheme = .default) {
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
