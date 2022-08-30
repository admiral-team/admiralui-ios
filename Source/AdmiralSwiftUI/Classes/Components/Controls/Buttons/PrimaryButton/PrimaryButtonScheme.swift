//
//  PrimaryButtonSheme.swift
//  AdmiralSwiftUI
//
//  Created on 09.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PrimaryButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - PrimaryButtonScheme() - Initialize default PrimaryButtonScheme with default themezation
 - PrimaryButtonScheme(
     font: AFont,
     backgroundColor: AColor,
     buttonBackgroundColorNormal: AColor,
     buttonBackgroundColorHighlighted: AColor,
     buttonBackgroundColorDisabled: AColor,
     textColorNormal: AColor,
     textColorDisabled: AColor
   )
 # Example to create PrimaryButtonScheme:
 # Code
 ```
let scheme = PrimaryButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PrimaryButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The font of PrimaryButton
    public let font: AFont

    /// The background of PrimaryButton
    public var backgroundColor: AColor

    /// The button background color of PrimaryButton
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// The text color of PrimaryButton
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        font = theme.fonts.body1

        backgroundColor = theme.colors.backgroundBasic

        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)

        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        textColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }

    public init(
        font: AFont,
        backgroundColor: AColor,
        buttonBackgroundColorNormal: AColor,
        buttonBackgroundColorHighlighted: AColor,
        buttonBackgroundColorDisabled: AColor,
        textColorNormal: AColor,
        textColorDisabled: AColor
    ) {
        self.font = font
        self.backgroundColor = backgroundColor

        buttonBackgroundColor.set(parameter: buttonBackgroundColorNormal, for: .normal)
        buttonBackgroundColor.set(parameter: buttonBackgroundColorHighlighted, for: .highlighted)
        buttonBackgroundColor.set(parameter: buttonBackgroundColorDisabled, for: .disabled)

        textColor.set(parameter: textColorNormal, for: .normal)
        textColor.set(parameter: textColorDisabled, for: .disabled)
    }

}
