//
//  DefaultAlertViewCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 DefaultAlertViewCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DefaultAlertViewCustomScheme() - Initialize default DefaultAlertViewCustomScheme with default themezation
Example to create DefaultAlertViewCustomScheme:
Code
 ```
let scheme = DefaultAlertViewCustomScheme()
 ```
 */
public struct DefaultAlertViewCustomScheme: AppThemeScheme {

    /// Background color of alert view.
    public var backgroundColor: AColor

    /// Default font of tittle label.
    public var defaultTitleFont: AFont

    /// Default font if message label.
    public var defaultMessageFont: AFont

    /// Styled font of title label that depends on AlertTitleFontStyle.
    public var titleFont = DefaultAlertViewCustomSchemeParameters<AFont, AlertTitleFontStyle>()

    /// Styled font of message label that depends on AlertMessageFontStyle.
    public var messageFont = DefaultAlertViewCustomSchemeParameters<AFont, AlertMessageFontStyle>()

    /// Styled color of title label that depends on AlertColorStyle.
    public var titleColor = DefaultAlertViewCustomSchemeParameters<AColor, AlertColorStyle>()

    /// Styled color of message label that depends on AlertColorStyle.
    public var messageColor = DefaultAlertViewCustomSchemeParameters<AColor, AlertColorStyle>()
    
    /// Scheme for PrimaryButton in AlertView action
    public var primaryButtonScheme: PrimaryButtonCustomScheme
    
    /// Scheme for GhostButton in AlertView action
    public var ghostButtonScheme: GhostButtonCustomScheme

    // MARK: - Initializer
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundExtraSurface
        defaultTitleFont = theme.fonts.title1
        defaultMessageFont = theme.fonts.subhead3

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
        
        primaryButtonScheme = PrimaryButtonCustomScheme(theme: theme)
        ghostButtonScheme = GhostButtonCustomScheme(theme: theme)
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

