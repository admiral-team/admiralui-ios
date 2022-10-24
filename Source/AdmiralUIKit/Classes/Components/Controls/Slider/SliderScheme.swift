//
//  SliderScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 SliderScheme - the visual scheme.
  You can create a by specifying the following parameters in init:
  - SliderScheme() - Initialize default SliderScheme with default themezation
 Example to create SliderScheme:
 Code
  ```
 let scheme = SliderScheme()
  ```
  */
public struct SliderScheme: AppThemeScheme {

    /// Tint color.
    public var tintColor = ControlParameter<AColor>()

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()

    /// Thumb border color.
    public var thumbBorderColor = ControlParameter<AColor>()

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

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
