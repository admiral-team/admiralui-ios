//
//  ChatButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 26.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct ChatButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The button color of ChatButton
    public var buttonColor = ControlParameter<AColor>()

    /// The send button color of ChatButton
    public var sendButtonColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .highlighted)
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.backgroundAccentPressed, for: .selected)
        buttonColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        sendButtonColor = theme.colors.elementStaticWhite
    }

}
