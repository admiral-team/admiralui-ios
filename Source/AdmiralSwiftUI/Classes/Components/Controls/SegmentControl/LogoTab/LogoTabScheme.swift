//
//  LogoTabObservable.swift
//  AdmiralUIResources
//
//  Created on 21.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 LogoTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - LogoTabScheme() - Initialize default LogoTabScheme with default themezation
 # Example to create LogoTabScheme:
 # Code
 ```
let scheme = LogoTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class LogoTabScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color
    public var backgroundColor: AColor

    /// The thumb color
    public var thumbColor = ControlParameter<AColor>()

    /// The border color
    public var borderColor = ControlParameter<AColor>()

    /// The alpha color
    public var alphaLogo = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic

        alphaLogo.set(parameter: 1.0, for: .normal)
        alphaLogo.set(parameter: 0.5, for: .disabled)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)

        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

}
