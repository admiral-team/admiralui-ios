//
//  PinButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 17.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import CoreGraphics

public struct PinButtonScheme: AppThemeScheme {

    public var selectedBackgroundColor: AColor
    public var backgroundColor: AColor
    public var disabledBackgroundColor: AColor
    public let frontColor: AColor
    public let shadowColor: AColor
    public var buttonImageColor: AColor

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        let shadowAlpha: CGFloat = 0.16

        disabledBackgroundColor = theme.colors.backgroundAccent.withAlpha(alpha)
        backgroundColor = theme.colors.backgroundAccent
        selectedBackgroundColor = theme.colors.backgroundAccentPressed
        frontColor = theme.colors.backgroundAccent.withAlpha(shadowAlpha)
        shadowColor = theme.colors.backgroundShadow
        buttonImageColor = theme.colors.elementStaticWhite
    }

}
