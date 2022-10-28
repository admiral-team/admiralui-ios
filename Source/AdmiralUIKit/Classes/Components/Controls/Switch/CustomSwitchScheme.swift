//
//  CustomSwitchScheme.swift
//  AdmiralUIKit
//
//  Created by on 27.10.2022.
//  
//


import AdmiralTheme
import AdmiralUIResources

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

    /// Tint color.
    public var tintColor: AColor

    /// On tint color.
    public var onTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        tintColor = theme.colors.elementPrimary
        onTintColor = theme.colors.elementAccent
    }
}


