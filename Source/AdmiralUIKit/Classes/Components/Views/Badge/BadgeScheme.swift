//
//  BadgeScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct BadgeScheme {
    var font: AFont
    var textColor = BadgeParameters<AColor>()
    var borderColor = BadgeParameters<AColor>()
    var backgroundColor = BadgeParameters<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        font = theme.fonts.caption2
        
        // Default
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .default)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal, style: .default)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .default)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .default)
        
        // Additional
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .additional)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .additional)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .additional)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .additional)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .additional)
        
        // Success
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .success)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .success)
        backgroundColor.set(parameter: theme.colors.elementSuccess, for: .normal, style: .success)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .success)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .success)
        
        // Error
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .error)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .error)
        backgroundColor.set(parameter: theme.colors.elementError, for: .normal, style: .error)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .error)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .error)
        
        // Attention
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .attention)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .attention)
        backgroundColor.set(parameter: theme.colors.elementAttention, for: .normal, style: .attention)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .attention)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .attention)
        
        // Natural
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .natural)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .natural)
        backgroundColor.set(parameter: theme.colors.elementSecondary, for: .normal, style: .natural)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .natural)
        borderColor.set(parameter: theme.colors.backgroundBasic, for: .disabled, style: .natural)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .natural)
    }
}

struct BadgeParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: BadgeState, style: BadgeStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: BadgeState, style: BadgeStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: BadgeState, style: BadgeStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }
    
}
