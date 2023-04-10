//
//  PinCodeInputScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 PinCodeInputScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinCodeInputScheme() - Initialize default PinCodeInputScheme with default themezation
Example to create PinCodeInputScheme:
Code
 ```
let scheme = PinCodeInputScheme()
 ```
 */
public struct PinCodeInputScheme: AppThemeScheme {

    /// Default color.
    public var defaultColor: AColor

    /// Active color.
    public var activeColor: AColor

    /// Success color.
    public var successColor: AColor

    /// Error color.
    public var errorColor: AColor
    
    public init(theme: AppTheme = .default) {
        defaultColor = theme.colors.elementAdditional
        activeColor = theme.colors.elementAccent
        successColor = theme.colors.elementSuccess
        errorColor = theme.colors.elementError
    }

}
