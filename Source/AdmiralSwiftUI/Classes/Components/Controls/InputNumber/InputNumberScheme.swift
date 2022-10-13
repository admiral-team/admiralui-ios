//
//  InputNumberStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 InputNumberScheme - the visual scheme of InputNumber.
 You can create a by specifying the following parameters in init:
 - InputNumberScheme() - Initialize default InputNumberScheme with default themezation
 # Example to create InputNumberScheme:
 ```
let scheme = InputNumberScheme()
 ```
 */
@available(iOS 14.0, *)
public final class InputNumberScheme: AppThemeScheme {

    /// The title font
    public var titleFont = ControlParameter<AFont>()

    /// The number font
    public var numberFont = ControlParameter<AFont>()

    /// The text color
    public var textColor = ControlParameter<AColor>()

    // The buttons visual scheme
    public var buttonScheme: InputNumberButtonScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        buttonScheme = InputNumberButtonScheme(theme: theme)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal)
        numberFont.set(parameter: theme.fonts.body1, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled)
    }
    
}
