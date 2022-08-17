//
//  CodeInputControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

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
}
