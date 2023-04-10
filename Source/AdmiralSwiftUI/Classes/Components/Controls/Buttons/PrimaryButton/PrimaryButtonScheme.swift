//
//  PrimaryButtonSheme.swift
//  AdmiralSwiftUI
//
//  Created on 09.04.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 PrimaryButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - PrimaryButtonScheme() - Initialize default PrimaryButtonScheme with default themezation
 # Example to create PrimaryButtonScheme:
 # Code
 ```
let scheme = PrimaryButtonScheme()
 ```
 */
public struct PrimaryButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The font of PrimaryButton
    public var font: AFont

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

}
