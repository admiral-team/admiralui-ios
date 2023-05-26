//
//  UploadDocumentViewScheme.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralTheme

/**
 UploadDocumentViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - UploadDocumentViewScheme() - Initialize default UploadDocumentViewScheme with default themezation
Example to create UploadDocumentViewScheme:
Code
 ```
let scheme = UploadDocumentViewScheme()
 ```
 */
public struct UploadDocumentViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// Text size font.
    public var sizeTextFont: AFont

    /// Text time font.
    public var timeTextFont: AFont

    /// Message text font.
    public var messageTextFont: AFont

    /// Message text color.
    public var messageTextColor: AColor

    /// Text font.
    public var textFont: AFont

    /// Background color.
    public var backgroundColor = UploadDocumentParameters<AColor>()

    /// Name text color.
    public var nameTextColor = UploadDocumentParameters<AColor>()

    /// Time text color.
    public var timeTextColor = UploadDocumentParameters<AColor>()

    /// Size color.
    public var sizeColor = UploadDocumentParameters<AColor>()

    /// Circle color.
    public var circleColor = UploadDocumentParameters<AColor>()

    /// Chevron color.
    public var chevronColor = UploadDocumentParameters<AColor>()

    /// Progress view scheme.
    public var progressViewScheme: ProgressViewScheme

    /// Chat bubble status view scheme.
    public var chatBubbleStatusViewScheme: ChatBubbleStatusViewScheme

    // MARK: - Initializer

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

        sizeColor.set(parameter: theme.colors.textAccentAdditional, style: .right)
        sizeColor.set(parameter: theme.colors.textSecondary, style: .left)

        circleColor.set(parameter: theme.colors.backgroundAccent, style: .left)
        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .right)

        chevronColor.set(parameter: theme.colors.elementAccent, style: .left)
        chevronColor.set(parameter: theme.colors.textStaticWhite, style: .right)

        progressViewScheme = ProgressViewScheme(theme: theme)
        chatBubbleStatusViewScheme = ChatBubbleStatusViewScheme(theme: theme)
    }

}

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
