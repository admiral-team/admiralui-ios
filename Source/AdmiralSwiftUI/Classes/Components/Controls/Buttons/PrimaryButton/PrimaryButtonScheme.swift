//
//  PrimaryButtonSheme.swift
//  AdmiralSwiftUI
//
//  Created on 09.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

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
    
}
