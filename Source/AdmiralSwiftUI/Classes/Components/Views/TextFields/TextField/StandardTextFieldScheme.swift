//
//  StandardTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 20.05.2021.
//
import AdmiralTheme
/**
 StandardTextFieldScheme - the visual scheme of StandardTextField.
 You can create a by specifying the following parameters in init:
 - StandardTextFieldScheme() - Initialize default StandardTextFieldScheme with default themezation
 # Example to create StandardTextFieldScheme:
 # Code
 ```
 let scheme = StandardTextFieldScheme()
 ```
 */
@available(iOS 14.0, *)
public struct StandardTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The tint color
    public var tintColor: AColor

    /// The titextnt color
    public var textColor: AColor

    /// The error color
    public var errorColor: AColor

    /// The disabled color
    public var disabledColor: AColor

    /// The underline color
    public var underlineColor: AColor

    /// The parameter that sets placeholder label color
    public var placeholderColor = ControlParameter<AColor>()

    /// The text field font
    public var textFieldFont: AFont

    /// The informer font
    public var informerFont: AFont

    /// The name font
    public var nameFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textSecondary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        
        placeholderColor.set(parameter: theme.colors.textSecondary, for: .normal)
        placeholderColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)

        textFieldFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
        nameFont = theme.fonts.subhead3
    }
    
}
