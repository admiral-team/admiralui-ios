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

    public var buttonColor = ControlParameter<AColor>()
    public var sendButtonColor: AColor

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .highlighted)
        buttonColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.backgroundAccentPressed, for: .selected)
        buttonColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        sendButtonColor = theme.colors.elementStaticWhite
    }

}
