//
//  CirclePageControlScheme.swift
//  AdmiralUI
//
//  Created on 27.01.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 CirclePageControlScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CirclePageControlScheme() - Initialize default CirclePageControlScheme with default themezation
Example to create CirclePageControlScheme:
Code
 ```
let scheme = CirclePageControlScheme()
 ```
 */
public struct CirclePageControlScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Center button background color.
    public var centerButtonBackgroundColor: AColor

    /// Progress color.
    public var progressColor: AColor

    /// Button image color.
    public var buttonImageColor: AColor
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        centerButtonBackgroundColor = theme.colors.elementAccent
        progressColor = theme.colors.elementAccent
        buttonImageColor = theme.colors.elementStaticWhite
    }
    
}
