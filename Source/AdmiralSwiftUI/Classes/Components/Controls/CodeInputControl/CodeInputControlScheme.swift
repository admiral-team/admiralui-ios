//
//  CodeInputControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 CodeInputControlScheme - the visual scheme of InputNumber.
 You can create a by specifying the following parameters in init:
 - CodeInputControlScheme() - Initialize default CodeInputControlScheme with default themezation
 # Example to create CodeInputControlScheme:
 ```
let scheme = CodeInputControlScheme()
 ```
 */
public struct CodeInputControlScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The default color
    public var defaultColor: AColor

    /// The active color
    public var activeColor: AColor

    /// The success color
    public var successColor: AColor

    /// The error color
    public var errorColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        defaultColor = theme.colors.elementAdditional
        activeColor = theme.colors.elementAccent
        successColor = theme.colors.elementSuccess
        errorColor = theme.colors.elementError
    }
}
