//
//  PlatformButtonScheme.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PlatformButtonScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - PlatformButtonScheme() - Initialize default PlatformButtonScheme with default themezation
 - PlatformButtonScheme(
     font: AFont,
     backgroundColor: AColor,
     buttonBackgroundColorNormal: AColor,
     buttonBackgroundColorHighlighted: AColor,
     buttonBackgroundColorDisabled: AColor,
     textColorNormal: AColor,
     textColorDisabled: AColor
   )
 # Example to create PlatformButtonScheme:
 # Code
 ```
let scheme = PlatformButtonScheme()
 ```
 */
public struct PlatformButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The font of PlatformButton
    public let font: AFont

    /// The background color of PlatformButton
    public var backgroundColor: AColor

    /// The button background color of PlatformButton
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// The text color of PlatformButton
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        let highlightedOpacity: CGFloat = 0.8

        font = theme.fonts.body1

        backgroundColor = theme.colors.backgroundBasic

        buttonBackgroundColor.set(parameter: theme.colors.textPrimary, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(highlightedOpacity), for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)

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

