//
//  NumberInputButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created by on 13.10.2022.
//  
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
/**
 NumberInputButtonScheme - the visual scheme for input number button.
 You can create a by specifying the following parameters in init:
 - NumberInputButtonScheme() - Initialize default NumberInputButtonScheme with default themezation
 # Example to create NumberInputButtonScheme:
 ```
let scheme = NumberInputButtonScheme()
 ```
 */
public final class NumberInputButtonScheme: AppThemeScheme {

    /// The text color
    public var tintColor = ControlParameter<AColor>()

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)

        tintColor.set(parameter: theme.colors.elementAccentPressed, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)

        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)
    }

}

