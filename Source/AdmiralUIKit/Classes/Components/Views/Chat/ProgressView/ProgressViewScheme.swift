//
//  ProgressViewScheme.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ProgressViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ProgressViewScheme() - Initialize default ProgressViewScheme with default themezation
Example to create ProgressViewScheme:
Code
 ```
let scheme = ProgressViewScheme()
 ```
 */
public struct ProgressViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// Background color.
    public var backgroundColor = ProgressViewSchemeParameters<AColor>()

    /// Icon color.
    public var iconColor = ProgressViewSchemeParameters<AColor>()

    /// Circular track view scheme.
    public var circularTrackViewScheme = CircularTrackViewScheme()
    
    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .accent)

        iconColor.set(parameter: theme.colors.elementAccent, style: .accent)
        iconColor.set(parameter: theme.colors.elementStaticWhite, style: .default)

        circularTrackViewScheme = CircularTrackViewScheme(theme: theme)
    }

}

/// A container for setting value for difference state.
public struct ProgressViewSchemeParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style progress view.
    public mutating func set(parameter: P?, style: ProgressViewStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style progress view.
    /// - Returns: Any value.
    public func parameter(style: ProgressViewStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ProgressViewStyle) -> String {
        return "\(style.rawValue)"
    }

}
