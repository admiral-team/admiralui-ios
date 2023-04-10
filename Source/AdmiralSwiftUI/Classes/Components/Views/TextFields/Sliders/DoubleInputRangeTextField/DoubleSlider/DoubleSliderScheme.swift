//
//  DoubleDoubleSliderScheme.swift
//  AdmiralSwiftUI
//
//  Created on 29.09.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 DoubleSliderScheme - the visual scheme of Slider.
 You can create a by specifying the following parameters in init:
 - DoubleSliderScheme() - Initialize default DoubleSliderScheme with default themezation
 # Example to create DoubleSliderScheme:
 # Code
 ```
 let scheme = DoubleSliderScheme()
 ```
 */
@available(iOS 14.0, *)
public struct DoubleSliderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The parameter that sets tint color with state
    public var tintColor = ControlParameter<AColor>()

    /// The parameter that sets thumb color with state
    public var thumbColor = ControlParameter<AColor>()

    /// The parameter that sets thumb border color with state
    public var thumbBorderColor = ControlParameter<AColor>()

    /// The parameter that sets background color with state
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        thumbBorderColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        
        tintColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .disabled)
        backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        thumbBorderColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
    }
}
