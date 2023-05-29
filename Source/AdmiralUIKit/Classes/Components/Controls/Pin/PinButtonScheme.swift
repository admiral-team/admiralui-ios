//
//  PinButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 17.02.2022.
//

import AdmiralTheme
import CoreGraphics

/**
 PinButtonScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinButtonScheme() - Initialize default PinButtonScheme with default themezation
Example to create PinButtonScheme:
Code
 ```
let scheme = PinButtonScheme()
 ```
 */
public struct PinButtonScheme: AppThemeScheme {

    /// Selected background color.
    public var selectedBackgroundColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    /// Disabled background color.
    public var disabledBackgroundColor: AColor

    /// Front color.
    public let frontColor: AColor

    /// Shadow color.
    public let shadowColor: AColor

    /// Button image color.
    public var buttonImageColor: AColor

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        let shadowAlpha: CGFloat = 0.16

        disabledBackgroundColor = theme.colors.backgroundAccent.withAlpha(alpha)
        backgroundColor = theme.colors.backgroundAccent
        selectedBackgroundColor = theme.colors.backgroundAccentPressed
        frontColor = theme.colors.backgroundAccent.withAlpha(shadowAlpha)
        shadowColor = theme.colors.backgroundShadow
        buttonImageColor = theme.colors.elementStaticWhite
    }

}
