//
//  FeedbackInputControlStyle.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 FeedbackInputControlScheme - the visual scheme of FeedbackInputControl.
 You can create a by specifying the following parameters in init:
 - FeedbackInputControlScheme() - Initialize default FeedbackInputControlScheme with default themezation
 # Example to create FeedbackInputControlScheme:
 # Code
 ```
 let scheme = FeedbackInputControlScheme()
 ```
 */
@available(iOS 14.0, *)
public struct FeedbackInputControlScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The parameter that sets title label default text color with state
    public var defaultColor = ControlParameter<AColor>()

    /// The parameter that sets title label selected text color with state
    public var selectedColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        defaultColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        selectedColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        defaultColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        selectedColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
