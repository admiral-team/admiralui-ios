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
 - LogoTabScheme(
     backgroundColor: AColor,
     alphaLogoNormal: Double,
     alphaLogoDisabled: Double,
     borderColorNormal: AColor,
     borderColorDisabled: AColor,
     thumbColorNormal: AColor,
     thumbColorSelected: AColor,
     thumbColorDisabled: AColor
   )
 # Example to create LogoTabScheme:
 # Code
 ```
let scheme = LogoTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class LogoTabScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of LogoTab
    public var backgroundColor: AColor

    /// The thumb color of LogoTab
    public var thumbColor = ControlParameter<AColor>()

    /// The border color of LogoTab
    public var borderColor = ControlParameter<AColor>()

    /// The alpha color of LogoTab
    public var alphaLogo = ControlParameter<Double>()

    // MARK: - Initializer

    public convenience init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        self.init(
            backgroundColor: theme.colors.backgroundBasic,
            alphaLogoNormal: 1.0,
            alphaLogoDisabled: 0.5,
            borderColorNormal: theme.colors.elementAdditional,
            borderColorDisabled: theme.colors.elementAdditional.withAlpha(alpha),
            thumbColorNormal: theme.colors.elementAccent,
            thumbColorSelected: theme.colors.elementAccent,
            thumbColorDisabled: theme.colors.elementAccent.withAlpha(alpha)
        )
    }

    public init(
        backgroundColor: AColor,
        alphaLogoNormal: Double,
        alphaLogoDisabled: Double,
        borderColorNormal: AColor,
        borderColorDisabled: AColor,
        thumbColorNormal: AColor,
        thumbColorSelected: AColor,
        thumbColorDisabled: AColor
    ) {
        self.backgroundColor = backgroundColor

        alphaLogo.set(parameter: alphaLogoNormal, for: .normal)
        alphaLogo.set(parameter: alphaLogoDisabled, for: .disabled)

        borderColor.set(parameter: borderColorNormal, for: .normal)
        borderColor.set(parameter: borderColorDisabled, for: .disabled)

        thumbColor.set(parameter: thumbColorNormal, for: .normal)
        thumbColor.set(parameter: thumbColorSelected, for: .selected)
        thumbColor.set(parameter: thumbColorDisabled, for: .disabled)
    }

}
