//
//  BadgeViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 06.08.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 BadgeViewScheme - the visual scheme .
 You can create a by specifying the following parameters in init:
 - BadgeViewScheme() - Initialize default BadgeViewScheme with default themezation
 # Example to create BadgeViewScheme:
 # Code
 ```
 let scheme = BadgeViewScheme()
 ```
 */
public struct BadgeViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The font
    public var font: AFont

    /// The border color
    public var borderColor: AColor

    /// The text color
    public var textColor = BadgeParameters<AColor>()

    /// The background color
    public var backgroundColor = BadgeParameters<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        font = theme.fonts.caption2
        borderColor = theme.colors.backgroundBasic

        // Default
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal, style: .default)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .default)

        // Additional
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .additional)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .additional)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .additional)

        // Success
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .success)
        backgroundColor.set(parameter: theme.colors.elementSuccess, for: .normal, style: .success)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .success)

        // Error
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .error)
        backgroundColor.set(parameter: theme.colors.elementError, for: .normal, style: .error)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .error)

        // Attention
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .attention)
        backgroundColor.set(parameter: theme.colors.elementAttention, for: .normal, style: .attention)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .attention)

        // Natural
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal, style: .natural)
        backgroundColor.set(parameter: theme.colors.elementSecondary, for: .normal, style: .natural)

        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .natural)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalTwo, for: .disabled, style: .natural)
    }
}

public struct BadgeParameters<P> {
    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, for state: ControlState, style: BadgeStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    func parameter(for state: ControlState, style: BadgeStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(state: ControlState, style: BadgeStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }

}
