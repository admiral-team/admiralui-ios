//
//  SmallInformerScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme

/**
 SmallInformerScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SmallInformerScheme() - Initialize default SmallInformerScheme with default themezation
Example to create SmallInformerScheme:
Code
 ```
let scheme = SmallInformerScheme()
 ```
 */
public struct SmallInformerScheme: AppThemeScheme {

    /// Title label text color.
    public var titleLabelTextColors = InformerParameters<AColor>()

    /// Background color.
    public var backgroundColors = InformerParameters<AColor>()

    /// Wrap view background color.
    public var wrapViewBackgroundColors = InformerParameters<AColor>()

    /// Title label font.
    public var titleLabelFont: AFont

    public init(theme: AppTheme = .default) {
        
        titleLabelFont = theme.fonts.body2
        
        // Default Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        backgroundColors.set(parameter: AColor.clear, isEnabled: true, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true, style: .default)

        // Success Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        backgroundColors.set(parameter: .clear, isEnabled: true, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: true, style: .success)
        
        // Attention Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        backgroundColors.set(parameter: .clear, isEnabled: true, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: true, style: .attention)
        
        // Error Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        backgroundColors.set(parameter: .clear, isEnabled: true, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: true, style: .error)
        
        // Default Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .default)
        backgroundColors.set(parameter: .clear, isEnabled: true, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: false, style: .default)

        // Success Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .success)
        backgroundColors.set(parameter: .clear, isEnabled: false, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: false, style: .success)
        
        // Attention Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .attention)
        backgroundColors.set(parameter: AColor.clear, isEnabled: false, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: false, style: .attention)
        
        // Error Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .error)
        backgroundColors.set(parameter: .clear, isEnabled: false, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: false, style: .error)
    }
    
}
