//
//  SecondaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct SecondaryButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The font of SecondaryButton
    public let font: AFont

    /// The font of SecondaryButton
    public var backgroundColor: AColor

    /// The text color of SecondaryButton
    public var textColor = ControlParameter<AColor>()

    /// The border color of SecondaryButton
    public var borderColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
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
