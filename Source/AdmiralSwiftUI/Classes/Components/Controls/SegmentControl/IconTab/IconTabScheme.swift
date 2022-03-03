//
//  IconTabScheme.swift
//  AdmiralUIResources
//
//  Created on 17.11.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public final class IconTabScheme: AppThemeScheme {

    // MARK: - Public properties

    public var backgroundColor: AColor
    public var titleColor = ControlParameter<AColor>()
    public var circleColor = ControlParameter<AColor>()
    public var alphaColor = ControlParameter<Double>()
    public var iconColor = ControlParameter<AColor>()
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic

        alphaColor.set(parameter: 1.0, for: .normal)
        alphaColor.set(parameter: 1.0, for: .selected)
        alphaColor.set(parameter: Double(alpha), for: .disabled)

        circleColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        circleColor.set(parameter: theme.colors.backgroundAccent, for: .selected)

        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleColor.set(parameter: theme.colors.textAccent, for: .selected)

        iconColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        iconColor.set(parameter: theme.colors.textStaticWhite, for: .selected)

        titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
    }

}
