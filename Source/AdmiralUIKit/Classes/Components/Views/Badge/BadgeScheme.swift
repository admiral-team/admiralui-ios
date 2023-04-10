//
//  BadgeScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 BadgeScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BadgeScheme() - Initialize default BadgeScheme with default themezation
Example to create BadgeScheme:
Code
 ```
let scheme = BadgeScheme()
 ```
 */
public struct BadgeScheme: AppThemeScheme {

    /// Text font.
    public var font: AFont

    /// Text color.
    public var textColor = BadgeParameters<AColor>()

    /// Border color.
    public var borderColor: AColor

    /// Background color.
    public var backgroundColor = BadgeParameters<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        font = theme.fonts.caption2
        borderColor = theme.colors.backgroundBasic

        // Default
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal, style: .default)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .default)

        // Additional
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .additional)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .additional)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .additional)

        // Success
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .success)
        backgroundColor.set(parameter: theme.colors.elementSuccess, for: .normal, style: .success)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .success)

        // Error
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .error)
        backgroundColor.set(parameter: theme.colors.elementError, for: .normal, style: .error)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .error)

        // Attention
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .attention)
        backgroundColor.set(parameter: theme.colors.elementAttention, for: .normal, style: .attention)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .attention)

        // Natural
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .natural)
        backgroundColor.set(parameter: theme.colors.elementSecondary.withAlpha(alpha), for: .normal, style: .natural)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .natural)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo.withAlpha(alpha), for: .disabled, style: .natural)

        // Clear
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .clear)
        backgroundColor.set(parameter: AColor.clear, for: .normal, style: .clear)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .clear)
        backgroundColor.set(parameter: AColor.clear, for: .disabled, style: .clear)
    }
}

/// A container for setting value for difference state.
public struct BadgeParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style badge view.
    public mutating func set(parameter: P?, for state: BadgeState, style: BadgeStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style badge view.
    /// - Returns: Any value.
    public func parameter(for state: BadgeState, style: BadgeStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: BadgeState, style: BadgeStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }
    
}
