//
//  CheckControlScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme

/**
 CheckControlScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CheckControlScheme() - Initialize default CheckTextControlScheme with default themezation
Example to create CheckControlScheme:
Code
 ```
let scheme = CheckControlScheme()
 ```
 */
public struct CheckControlScheme {

    /// Normal control color.
    public var normal = ControlParameter<AColor>()

    /// Error control color.
    public var error = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        normal.set(parameter: theme.colors.elementAccent, for: .normal)
        error.set(parameter: theme.colors.elementError, for: .normal)
        
        normal.set(parameter: theme.colors.elementAccentPressed, for: .highlighted)
        error.set(parameter: theme.colors.elementError, for: .highlighted)
        
        normal.set(parameter: theme.colors.elementAccentPressed, for: [.highlighted, .selected])
        error.set(parameter: theme.colors.elementError, for: [.highlighted, .selected])
        
        normal.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        error.set(parameter: theme.colors.elementError.withAlpha(alpha), for: .disabled)
        
        normal.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        error.set(parameter: theme.colors.elementError.withAlpha(alpha), for: [.disabled, .selected])
    }
    
}
