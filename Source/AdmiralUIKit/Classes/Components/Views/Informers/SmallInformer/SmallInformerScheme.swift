//
//  SmallInformerScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct SmallInformerScheme {
    
    var titleLabelTextColors = InformerParameters<AColor>()
    var backgroundColors = InformerParameters<AColor>()
    var wrapViewBackgroundColors = InformerParameters<AColor>()
    
    var titleLabelFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        
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
