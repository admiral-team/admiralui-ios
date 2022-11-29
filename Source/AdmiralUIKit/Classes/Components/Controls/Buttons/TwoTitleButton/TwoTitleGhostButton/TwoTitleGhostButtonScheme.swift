//
//  TwoTitleGhostButtonScheme.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 TwoTitleGhostButtonScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TwoTitleGhostButtonScheme() - Initialize default TwoTitleGhostButtonScheme with default themezation
Example to create TwoTitleGhostButtonScheme:
Code
 ```
let scheme = TwoTitleGhostButtonScheme()
 ```
 */
public struct TwoTitleGhostButtonScheme: AppThemeScheme {

    /// Left title color.
    public var leftTitleColor = ControlParameter<AColor>()

    /// Right title color.
    public var rightTitleColor = ControlParameter<AColor>()

    /// Background color.
    public var backgroundColor: AColor

    /// Left label font.
    public var leftLabelFont: AFont

    /// Right label font.
    public var rightLabelFont: AFont
    
    public init(theme: AppTheme = .default) {
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
