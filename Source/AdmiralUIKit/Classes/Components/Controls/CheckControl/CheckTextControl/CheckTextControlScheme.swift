//
//  CheckTextControlScheme.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import AdmiralTheme

/**
 CheckTextControlScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CheckTextControlScheme() - Initialize default CheckTextControlScheme with default themezation
Example to create CheckTextControlScheme:
Code
 ```
let scheme = CheckTextControlScheme()
 ```
 */
public struct CheckTextControlScheme: AppThemeScheme {

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    /// Check control scheme.
    public var checkControlScheme = CheckControlScheme()

    /// Text font.
    public var textFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled, .selected])
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled, .normal])
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: [.disabled])
        checkControlScheme = CheckControlScheme(theme: theme)
        textFont = theme.fonts.subhead4
    }
    
}
