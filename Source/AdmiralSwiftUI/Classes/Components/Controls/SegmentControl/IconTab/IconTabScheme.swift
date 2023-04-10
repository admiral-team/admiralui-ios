//
//  IconTabScheme.swift
//  AdmiralUIResources
//
//  Created on 17.11.2021.
//

import SwiftUI
import Combine
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 IconTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - IconTabScheme() - Initialize default IconTabScheme with default themezation
 # Example to create IconTabScheme:
 # Code
 ```
let scheme = IconTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class IconTabScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The background color of IconTab
    public var backgroundColor: AColor

    /// The title color of IconTab
    public var titleColor = ControlParameter<AColor>()

    /// The circle color of IconTab
    public var circleColor = ControlParameter<AColor>()

    /// The alpha color of IconTab
    public var alphaColor = ControlParameter<Double>()

    /// The icon color of IconTab
    public var iconColor = ControlParameter<AColor>()

    /// The title color of IconTab
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
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
