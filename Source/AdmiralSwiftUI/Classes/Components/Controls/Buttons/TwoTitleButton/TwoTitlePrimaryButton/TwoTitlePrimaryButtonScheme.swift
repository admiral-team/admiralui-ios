//
//  TwoTitleButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 TwoTitlePrimaryButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - TwoTitlePrimaryButtonScheme() - Initialize default TwoTitlePrimaryButtonScheme with default themezation
 - TwoTitlePrimaryButtonScheme(
    leftLabelFont: AFont,
    rightLabelFont: AFont,
    backgroundColor: AColor,

    buttonBackgroundColorNormal: AColor,
    buttonBackgroundColorHighlighted: AColor,
    buttonBackgroundColorDisabled: AColor,

    leftTitleColorNormal: AColor,
    leftTitleColorDisabled: AColor,

    rightTitleColorNormal: AColor,
    rightTitleColorDisabled: AColor
   )
 # Example to create TwoTitlePrimaryButtonScheme:
 # Code
 ```
let scheme = TwoTitlePrimaryButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TwoTitlePrimaryButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The left title color of TwoTitlePrimaryButton
    public var leftTitleColor = ControlParameter<AColor>()

    /// The left title color of TwoTitlePrimaryButton
    public var rightTitleColor = ControlParameter<AColor>()

    /// The left title color of TwoTitlePrimaryButton
    public var backgroundColor: AColor

    /// The left title color of TwoTitlePrimaryButton
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// The left label font
    public var leftLabelFont: AFont

    /// The right label font
    public var rightLabelFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        leftLabelFont = theme.fonts.subhead3
        rightLabelFont = theme.fonts.body1

        backgroundColor = theme.colors.backgroundBasic

        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)

        leftTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        leftTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)

        rightTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        rightTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }

    public init(
        leftLabelFont: AFont,
        rightLabelFont: AFont,
        backgroundColor: AColor,

        buttonBackgroundColorNormal: AColor,
        buttonBackgroundColorHighlighted: AColor,
        buttonBackgroundColorDisabled: AColor,

        leftTitleColorNormal: AColor,
        leftTitleColorDisabled: AColor,

        rightTitleColorNormal: AColor,
        rightTitleColorDisabled: AColor
    ) {
        self.leftLabelFont = leftLabelFont
        self.rightLabelFont = rightLabelFont

        self.backgroundColor = backgroundColor

        buttonBackgroundColor.set(parameter: buttonBackgroundColorNormal, for: .normal)
        buttonBackgroundColor.set(parameter: buttonBackgroundColorHighlighted, for: .highlighted)
        buttonBackgroundColor.set(parameter: buttonBackgroundColorDisabled, for: .disabled)

        leftTitleColor.set(parameter: leftTitleColorNormal, for: .normal)
        leftTitleColor.set(parameter: leftTitleColorDisabled, for: .disabled)

        rightTitleColor.set(parameter: rightTitleColorNormal, for: .normal)
        rightTitleColor.set(parameter: rightTitleColorDisabled, for: .disabled)
    }

}
