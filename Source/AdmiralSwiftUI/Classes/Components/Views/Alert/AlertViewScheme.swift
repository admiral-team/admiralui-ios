//
//  AlertViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 10.01.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ActivityIndicatorScheme - the visual scheme of AlertView.
 You can create a by specifying the following parameters in init:
 - AlertViewScheme() - Initialize default AlertViewScheme with default themezation
 # Example to create AlertViewScheme:
 # Code
 ```
 let scheme = AlertViewScheme()
 ```
 */
public struct AlertViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// Styled font of title label that configurable with style
    public var titleFont = DefaultAlertViewCustomSchemeParameters<AFont, AlertTitleFontStyle>()

    /// Styled font of message label that configurable with style
    public var messageFont = DefaultAlertViewCustomSchemeParameters<AFont, AlertMessageFontStyle>()

    /// Styled  color of title label that configurable with style
    public var titleColor = DefaultAlertViewCustomSchemeParameters<AColor, AlertColorStyle>()

    /// Styled  color of meesage label that configurable with style
    public var messageColor = DefaultAlertViewCustomSchemeParameters<AColor, AlertColorStyle>()

    /// The background color.
    public var backgroundColor: AColor

    /// Button scheme.
    public var buttonScheme: PrimaryButtonScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleFont.set(parameter: theme.fonts.title1, style: .title1)
        titleFont.set(parameter: theme.fonts.title2, style: .title2)
        titleFont.set(parameter: theme.fonts.subtitle1, style: .subtitle1)
        titleFont.set(parameter: theme.fonts.subtitle2, style: .subtitle2)
        titleFont.set(parameter: theme.fonts.headline, style: .headLine)

        messageFont.set(parameter: theme.fonts.body1, style: .body1)
        messageFont.set(parameter: theme.fonts.body2, style: .body2)
        messageFont.set(parameter: theme.fonts.subhead4, style: .subhead4)
        messageFont.set(parameter: theme.fonts.subhead3, style: .subhead3)

        titleColor.set(parameter: theme.colors.textAdditional, style: .additional)
        titleColor.set(parameter: theme.colors.textMask, style: .mask)
        titleColor.set(parameter: theme.colors.textPrimary, style: .primary)
        titleColor.set(parameter: theme.colors.textSecondary, style: .secondary)

        messageColor.set(parameter: theme.colors.textAdditional, style: .additional)
        messageColor.set(parameter: theme.colors.textMask, style: .mask)
        messageColor.set(parameter: theme.colors.textPrimary, style: .primary)
        messageColor.set(parameter: theme.colors.textSecondary, style: .secondary)

        backgroundColor = theme.colors.backgroundExtraSurface

        buttonScheme = PrimaryButtonScheme(theme: theme)
    }

}

public struct DefaultAlertViewCustomSchemeParameters<P, S: RawRepresentable & Hashable> where S.RawValue == Int {

    var parameters: [String: P?] = [:]
    typealias style = S

    mutating func set(parameter: P?, style: style) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    func parameter(style: style) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: style) -> String {
        return "\(style.rawValue)"
    }

}
