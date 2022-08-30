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
 - ChatButtonScheme(
     buttonColorHighlighted: AColor,
     buttonColorNormal: AColor,
     buttonColorSelected: AColor,
     buttonColorDisabled: AColor,
     sendButtonColor: AColor
   )
 # Example to create ChatButtonScheme:
 # Code
 ```
let scheme = ChatButtonScheme()
 ```
 */
public struct ChatButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The button color of ChatButton
    public var buttonColor = ControlParameter<AColor>()

    /// The send button color of ChatButton
    public var sendButtonColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .highlighted)
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.backgroundAccentPressed, for: .selected)
        buttonColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        sendButtonColor = theme.colors.elementStaticWhite
    }

    public init(
        buttonColorHighlighted: AColor,
        buttonColorNormal: AColor,
        buttonColorSelected: AColor,
        buttonColorDisabled: AColor,
        sendButtonColor: AColor
    ) {
        buttonColor.set(parameter: buttonColorHighlighted, for: .highlighted)
        buttonColor.set(parameter: buttonColorNormal, for: .normal)
        buttonColor.set(parameter: buttonColorSelected, for: .selected)
        buttonColor.set(parameter: buttonColorDisabled, for: .disabled)
        self.sendButtonColor = sendButtonColor
    }

}

