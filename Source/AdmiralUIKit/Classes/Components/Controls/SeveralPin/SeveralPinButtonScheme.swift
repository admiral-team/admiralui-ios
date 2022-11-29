//
//  SeveralPinButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 17.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

/**
 SeveralPinButtonScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SeveralPinButtonScheme() - Initialize default SeveralPinButtonScheme with default themezation
Example to create SeveralPinButtonScheme:
Code
 ```
let scheme = SeveralPinButtonScheme()
 ```
 */
public struct SeveralPinButtonScheme: AppThemeScheme {

    /// Border color.
    public let borderColor: AColor

    /// Border pressed color.
    public let borderColorPressed: AColor

    /// Border disabled color.
    public let borderColorDisabled: AColor

    /// Background color.
    public let backgroundColor: AColor

    /// Text color.
    public let textColor: AColor

    /// Shadow color.
    public let shadowColor: AColor

    /// Disabled color.
    public let disabledColor: AColor

    /// Font.
    public let font: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        disabledColor = theme.colors.textPrimary.withAlpha(alpha)
        textColor = theme.colors.textPrimary
        font = theme.fonts.caption1
        backgroundColor = theme.colors.backgroundBasic
        borderColor = theme.colors.backgroundAccent
        borderColorPressed = theme.colors.backgroundAccentPressed
        borderColorDisabled = theme.colors.backgroundAccent.withAlpha(alpha)
        shadowColor = theme.colors.backgroundShadow
    }

}
