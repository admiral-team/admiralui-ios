//
//  TextOperationViewScheme.swift
//  AdmiralUIKit
//
//  Created on 14.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TextOperationViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TextOperationViewScheme() - Initialize default TextOperationViewScheme with default themezation
Example to create TextOperationViewScheme:
Code
 ```
let scheme = TextOperationViewScheme()
 ```
 */
public struct TextOperationViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The main view background color.
    public var backgroundColor = TextOperationViewSchemeParameters<AColor>()

    /// The title  label color.
    public var titleColor = TextOperationViewSchemeParameters<AColor>()
    
    /// A color of Error Image.
    public var errorImageColor: AColor

    /// The desciption label color.
    public var desciptionColor: AColor

    /// The time label color.
    public var timeColor: AColor

    /// The title label font.
    public var titleFont: AFont

    /// The desciption label font.
    public var desciptionFont: AFont

    /// The time label font.
    public var timeFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundError, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, style: .success)

        titleColor.set(parameter: theme.colors.textPrimary, style: .default)
        titleColor.set(parameter: theme.colors.textError, style: .error)
        titleColor.set(parameter: theme.colors.textSuccess, style: .success)

        desciptionColor = theme.colors.textPrimary
        timeColor = theme.colors.textSecondary
        errorImageColor = theme.colors.elementError

        titleFont = theme.fonts.subhead1
        desciptionFont = theme.fonts.subhead3
        timeFont = theme.fonts.caption1
    }

}

/// A container for setting value for difference state.
public struct TextOperationViewSchemeParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style text operation view.
    public mutating func set(parameter: P?, style: TextOperationViewStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style text operation  view.
    /// - Returns: Any value.
    public func parameter(style: TextOperationViewStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: TextOperationViewStyle) -> String {
        return "\(style.rawValue)"
    }

}
