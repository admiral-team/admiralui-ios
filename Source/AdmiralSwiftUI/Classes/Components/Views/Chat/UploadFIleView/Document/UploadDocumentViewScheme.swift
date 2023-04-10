//
//  UploadDocumentViewScheme.swift
//  AdmiralUIResources
//
//  Created on 01.11.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 UploadDocumentViewScheme - the visual scheme of UploadDocumentView.
 You can create a by specifying the following parameters in init:
 - UploadDocumentViewScheme() - Initialize default UploadDocumentViewScheme with default themezation
 # Example to create UploadDocumentViewScheme:
 # Code
 ```
 let scheme = UploadDocumentViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct UploadDocumentViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The font of size text label
    public var sizeTextFont: AFont

    /// The font of time text label
    public var timeTextFont: AFont

    /// The font of message text label
    public var messageTextFont: AFont

    /// The color of message text label
    public var messageTextColor: AColor

    /// The text font
    public var textFont: AFont

    /// The background color
    public var backgroundColor = UploadDocumentParameters<AColor>()

    /// The name color
    public var nameTextColor = UploadDocumentParameters<AColor>()

    /// The time  color
    public var timeTextColor = UploadDocumentParameters<AColor>()

    /// The icon color
    public var iconColor = UploadDocumentParameters<AColor>()

    /// The size color
    public var sizeColor = UploadDocumentParameters<AColor>()

    /// The circle color
    public var circleColor = UploadDocumentParameters<AColor>()

    /// The chevron color
    public var chevronColor = UploadDocumentParameters<AColor>()

    // MARK: - Init/deinit

    public init(theme: AppTheme = .default) {
        textFont = theme.fonts.body1
        timeTextFont = theme.fonts.caption1
        sizeTextFont = theme.fonts.caption2

        messageTextFont = theme.fonts.caption1
        messageTextColor = theme.colors.textSecondary

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .left)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .right)

        nameTextColor.set(parameter: theme.colors.textStaticWhite, style: .right)
        nameTextColor.set(parameter: theme.colors.textPrimary, style: .left)

        timeTextColor.set(parameter: theme.colors.textAccentAdditional, style: .right)
        timeTextColor.set(parameter: theme.colors.textSecondary, style: .left)

        iconColor.set(parameter: theme.colors.elementAccent, style: .right)
        iconColor.set(parameter: theme.colors.elementStaticWhite, style: .left)

        sizeColor.set(parameter: theme.colors.textAccentAdditional, style: .right)
        sizeColor.set(parameter: theme.colors.textSecondary, style: .left)

        circleColor.set(parameter: theme.colors.backgroundAccent, style: .left)
        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .right)

        chevronColor.set(parameter: theme.colors.elementAccent, style: .left)
        chevronColor.set(parameter: theme.colors.textStaticWhite, style: .right)
    }

}

@available(iOS 14.0.0, *)
public struct UploadDocumentParameters<P> {
    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, style: ChatDirection) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    func parameter(style: ChatDirection) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ChatDirection) -> String {
        return "\(style.rawValue)"
    }

}

