//
//  ChatButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 26.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 ChatButtonScheme - the visual scheme of ChatButton.
 You can create a by specifying the following parameters in init:
 - ChatButtonScheme() - Initialize default ChatButtonScheme with default themezation
 # Example to create ChatButtonScheme:
 # Code
 ```
let scheme = ChatButtonScheme()
 ```
 */
public struct ChatButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The button color
    public var buttonColor = ControlParameter<AColor>()

    /// The send button color
    public var sendButtonColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        sendButtonColor = theme.colors.elementStaticWhite
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .highlighted)
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.backgroundAccentPressed, for: .selected)
        buttonColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
    }

}

