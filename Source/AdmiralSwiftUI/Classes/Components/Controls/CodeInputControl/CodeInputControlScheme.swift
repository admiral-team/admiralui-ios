//
//  CodeInputControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 CodeInputControlScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - CodeInputControlScheme() - Initialize default CodeInputControlScheme with default themezation
 - CodeInputControlScheme(
     defaultColor: AColor,
     activeColor: AColor,
     successColor: AColor,
     errorColor: AColor
   )
 # Example to create CodeInputControlScheme:
 # Code
 ```
let scheme = CodeInputControlScheme()
 ```
 */
public struct CodeInputControlScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The default color of CodeInputControl
    public var defaultColor: AColor

    /// The active color of CodeInput control
    public var activeColor: AColor

    /// The success color of CodeInputControl
    public var successColor: AColor

    /// The error color of CodeInputControl
    public var errorColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        defaultColor = theme.colors.elementAdditional
        activeColor = theme.colors.elementAccent
        successColor = theme.colors.elementSuccess
        errorColor = theme.colors.elementError
    }

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(
        defaultColor: AColor,
        activeColor: AColor,
        successColor: AColor,
        errorColor: AColor
    ) {
        self.defaultColor = defaultColor
        self.activeColor = activeColor
        self.successColor = successColor
        self.errorColor = errorColor
    }
}
