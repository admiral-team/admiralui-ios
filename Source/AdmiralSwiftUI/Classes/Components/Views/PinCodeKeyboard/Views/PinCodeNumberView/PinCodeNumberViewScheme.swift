//
//  PinCodeNumberViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 30.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinCodeNumberViewScheme - the visual scheme of PinCodeNumberView.
 You can create a by specifying the following parameters in init:
 - PinCodeNumberViewScheme() - Initialize default PinCodeNumberViewScheme with default themezation
 - PinCodeNumberViewScheme(
 backgroundColorNormal: AColor,
 backgroundColorHighlighted: AColor,
 imageColor: AColor,
 textColor: AColor,
 textFont: AFont
 )
 # Example to create PinCodeNumberViewScheme:
 # Code
 ```
 let scheme = PinCodeNumberViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PinCodeNumberViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PinCodeNumberView
    public var backgroundColor = ControlParameter<AColor>()

    /// The background color of PinCodeNumberView
    public var imageColor: AColor

    /// The background color of PinCodeNumberView
    public var textColor: AColor

    /// The background color of PinCodeNumberView
    public var textFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)

        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        textFont = theme.fonts.body2
    }

    public init(
        backgroundColorNormal: AColor,
        backgroundColorHighlighted: AColor,
        imageColor: AColor,
        textColor: AColor,
        textFont: AFont
    ) {
        backgroundColor.set(parameter: backgroundColorNormal, for: .normal)
        backgroundColor.set(parameter: backgroundColorHighlighted, for: .highlighted)

        self.textColor = textColor
        self.imageColor = imageColor
        self.textFont = textFont
    }

}
