//
//  BigInformerObservable.swift
//  AdmiralUIResources
//
//  Created on 18.05.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct BigInformerScheme: AppThemeScheme {
    
    // MARK: - Public Properties
    
    public var titleLabelTextColors = InformerParameters<AColor>()
    public var subtitleLabelTextColors = InformerParameters<AColor>()
    public var linkLabelTextColors = InformerParameters<AColor>()
    public var wrapViewBackgroundColors = InformerParameters<AColor>()
    public var backgroundColors = InformerParameters<AColor>()
    
    public var titleLabelFont: AFont = AppTheme.default.fonts.subtitle2
    public var subtitleLabelFont: AFont = AppTheme.default.fonts.body2
    public var linkLabelFont: AFont = AppTheme.default.fonts.body2
    
    // MARK: - Initilizers
    
    public init(theme: AppTheme)  {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.subtitle2
        subtitleLabelFont = theme.fonts.body2
        linkLabelFont = theme.fonts.body2
        
        // Default Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .default)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true, style: .default)

        // Success Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .success)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: true, style: .success)
        
        // Attention Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .attention)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: true, style: .attention)
        
        // Error Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true, style: .error)
        linkLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: true, style: .error)
        
        // Default Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .default)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .default)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .default)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .default)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: false, style: .default)

        // Success Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .success)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .success)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .success)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .success)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundSuccess, isEnabled: false, style: .success)
        
        // Attention Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .attention)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .attention)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .attention)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .attention)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAttention, isEnabled: false, style: .attention)
        
        // Error Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .error)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false, style: .error)
        linkLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false, style: .error)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false, style: .error)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundError, isEnabled: false, style: .error)
    }
    
}

public struct InformerParameters<P> {
    
    public var parameters: [String: P?] = [:]
    
    public mutating func set(parameter: P?, isEnabled: Bool, style: InformerStyleSwiftUI) {
        let key = paramKey(isEnabled: isEnabled, style: style)
        parameters[key] = parameter
    }
    
    public func parameter(isEnabled: Bool, style: InformerStyleSwiftUI) -> P? {
        let key = paramKey(isEnabled: isEnabled, style: style)
        let defaultKey = paramKey(isEnabled: true, style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool, style: InformerStyleSwiftUI) -> String {
        return "\(isEnabled ? 1 : 0).\(style.rawValue)"
    }
    
}
