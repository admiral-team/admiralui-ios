//
//  SecondaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//
import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 SecondaryButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - SecondaryButtonScheme() - Initialize default SecondaryButtonScheme with default themezation
 # Example to create SecondaryButtonScheme:
 # Code
 ```
let scheme = SecondaryButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct SecondaryButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The font of SecondaryButton
    public var font: AFont

    /// The font of SecondaryButton
    public var backgroundColor: AColor

    /// The text color of SecondaryButton
    public var textColor = ControlParameter<AColor>()

    /// The border color of SecondaryButton
    public var borderColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        font = theme.fonts.body1

        backgroundColor = theme.colors.backgroundBasic

        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)

        borderColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        borderColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        borderColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
    }

}
