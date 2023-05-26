//
//  SmallInformerObservable.swift
//  AdmiralUIResources
//
//  Created on 24.05.2021.
//
import AdmiralTheme
/**
 SmallInformerScheme - the visual scheme of SmallInformer.
 You can create a by specifying the following parameters in init:
 - SmallInformerScheme() - Initialize default SmallInformerScheme with default themezation
 # Example to create SmallInformerScheme:
 # Code
 ```
 let scheme = SmallInformerScheme()
 ```
 */
@available(iOS 14.0, *)
public struct SmallInformerScheme: AppThemeScheme {
    
    // MARK: - Public Properties

    /// The parameter that sets title label text color with state
    public var titleLabelTextColors = InformerParameters<AColor>()

    /// The parameter that sets wrap view background color with state
    public var wrapViewBackgroundColors = InformerParameters<AColor>()

    /// The parameter that sets background color with state
    public var backgroundColors = InformerParameters<AColor>()

    /// The title label font
    public var titleLabelFont: AFont
    
    // MARK: - Initializer
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body2
        
        // Default Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true, style: .default)

        // Success Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: true, style: .success)
        
        // Attention Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: true, style: .attention)
        
        // Error Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: true, style: .error)
        
        // Default Disabled
        titleLabelTextColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: false, style: .default)

        // Success Disabled
        titleLabelTextColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: false, style: .success)
        
        // Attention Disabled
        titleLabelTextColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: false, style: .attention)
        
        // Error Disabled
        titleLabelTextColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: false, style: .error)
    }
    
}
