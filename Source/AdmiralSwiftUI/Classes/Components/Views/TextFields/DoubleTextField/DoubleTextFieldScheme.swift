//
//  DoubleTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 02.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 DoubleTextFieldScheme - the visual scheme of DoubleTextField.
 You can create a by specifying the following parameters in init:
 - DoubleTextFieldScheme() - Initialize default DoubleTextFieldScheme with default themezation
 # Example to create DoubleTextFieldScheme:
 # Code
 ```
 let scheme = DoubleTextFieldScheme()
 ```
 */
@available(iOS 14.0, *)
public struct DoubleTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The error icon color
    public var errorColor: AColor

    /// The underline color
    public var underlineColor: AColor

    /// The diabled color
    public var disabledColor: AColor

    /// The informer font
    public var informerFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        self.informerFont = theme.fonts.subhead3
        
        self.errorColor = theme.colors.textError
        self.underlineColor = theme.colors.textSecondary
        self.disabledColor = theme.colors.textSecondary.withAlpha(alpha)
    }
}
