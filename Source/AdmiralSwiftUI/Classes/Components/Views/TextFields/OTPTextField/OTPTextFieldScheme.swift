//
//  OTPTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 25.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 OTPTextFieldScheme - the visual scheme of OTPTextField.
 You can create a by specifying the following parameters in init:
 - OTPTextFieldScheme() - Initialize default OTPTextFieldScheme with default themezation
 # Example to create OTPTextFieldScheme:
 # Code
 ```
 let scheme = OTPTextFieldScheme()
 ```
 */
@available(iOS 14.0, *)
public struct OTPTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The tint color
    public var tintColor: AColor

    /// The text color
    public var textColor: AColor

    /// The error color
    public var errorColor: AColor

    /// The disabled color
    public var disabledColor: AColor

    /// The underline color
    public var underlineColor: AColor

    /// The placholder color
    public var placeholderColor: AColor

    /// The text field font
    public var textFieldFont: AFont

    /// The placeholder font
    public var placeholderFont: AFont

    /// The informer font
    public var informerFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textSecondary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        placeholderColor = theme.colors.textSecondary.withAlpha(alpha)
        
        textFieldFont = theme.fonts.title2
        placeholderFont = theme.fonts.title2
        informerFont = theme.fonts.subhead3
    }
    
}
