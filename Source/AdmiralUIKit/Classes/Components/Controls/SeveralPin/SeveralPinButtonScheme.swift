//
//  SeveralPinButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 17.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

public struct SeveralPinButtonScheme: AppThemeScheme {

    public let borderColor: AColor
    public let borderColorPressed: AColor
    public let borderColorDisabled: AColor
    public let backgroundColor: AColor
    public let textColor: AColor
    public let shadowColor: AColor
    public let disabledColor: AColor
    public let font: AFont

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        disabledColor = theme.colors.textPrimary.withAlpha(alpha)
        textColor = theme.colors.textPrimary
        font = theme.fonts.caption1
        backgroundColor = theme.colors.backgroundBasic
        borderColor = theme.colors.backgroundAccent
        borderColorPressed = theme.colors.backgroundAccentPressed
        borderColorDisabled = theme.colors.backgroundAccent.withAlpha(alpha)
        shadowColor = theme.colors.backgroundShadow
    }

}
