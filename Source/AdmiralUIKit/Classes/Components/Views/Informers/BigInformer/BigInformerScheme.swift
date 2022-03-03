//
//  BigInformerScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct BigInformerScheme {
    
    var titleLabelTextColors = InformerParameters<AColor>()
    var descriptionLabelTextColors = InformerParameters<AColor>()
    var linkLabelTextColors = InformerParameters<AColor>()
    var wrapViewBackgroundColors = InformerParameters<AColor>()
    var backgroundColors = InformerParameters<AColor>()
    
    var titleLabelFont: AFont
    var descriptionLabelFont: AFont
    var linkLabelFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.subtitle2
        descriptionLabelFont = theme.fonts.body2
        linkLabelFont = theme.fonts.body2
        
        // Default Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        descriptionLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true, style: .default)

        // Success Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        descriptionLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: true, style: .success)
        
        // Attention Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        descriptionLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: true, style: .attention)
        
        // Error Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        descriptionLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: true, style: .error)
        
        // Default Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .default)
        descriptionLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .default)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: false, style: .default)

        // Success Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .success)
        descriptionLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .success)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: false, style: .success)
        
        // Attention Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .attention)
        descriptionLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .attention)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: false, style: .attention)
        
        // Error Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .error)
        descriptionLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .error)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: false, style: .error)
    }
    
}

struct InformerParameters<P> {
    
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, isEnabled: Bool, style: InformerStyle) {
        let key = paramKey(isEnabled: isEnabled, style: style)
        parameters[key] = parameter
    }
    
    func parameter(isEnabled: Bool, style: InformerStyle) -> P? {
        let key = paramKey(isEnabled: isEnabled, style: style)
        let defaultKey = paramKey(isEnabled: true, style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool, style: InformerStyle) -> String {
        return "\(isEnabled ? 1 : 0).\(style.rawValue)"
    }
    
}
