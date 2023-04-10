//
//  CustomSwitchScheme.swift
//  AdmiralUIKit
//
//  Created by on 27.10.2022.
//  
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import AdmiralTheme
/**
 CustomSwitchScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CustomSwitchScheme() - Initialize default CustomSwitchScheme with default themezation
Example to create CustomSwitchScheme:
Code
 ```
let scheme = CustomSwitchScheme()
 ```
 */
public struct CustomSwitchScheme: AppThemeScheme {

    // MARK: - Public properties

    /// Tint color.
    public var tintColor: AColor

    /// On tint color.
    public var onTintColor: AColor

    /// The font
    public var font: AFont

    /// The text color
    public var textColor: AColor

    /// The disabled text color
    public var disabledTextColor: AColor

    /// The disabled tint color
    public var disabledTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        tintColor = theme.colors.elementPrimary
        onTintColor = theme.colors.elementAccent
        font = theme.fonts.body1
        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        disabledTextColor = theme.colors.textPrimary.withAlpha(alpha)
        disabledTintColor = theme.colors.elementAccent.withAlpha(alpha)
    }
}
