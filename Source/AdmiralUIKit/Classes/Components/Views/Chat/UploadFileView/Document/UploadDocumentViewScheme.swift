//
//  UploadDocumentViewScheme.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct UploadDocumentViewScheme: AppThemeScheme {

    // MARK: - Public properties

    public let sizeTextFont: AFont
    public let timeTextFont: AFont

    public var messageTextFont: AFont
    public var messageTextColor: AColor

    public let textFont: AFont
    public var backgroundColor = UploadDocumentParameters<AColor>()
    public var nameTextColor = UploadDocumentParameters<AColor>()
    public var timeTextColor = UploadDocumentParameters<AColor>()
    public var sizeColor = UploadDocumentParameters<AColor>()
    public var circleColor = UploadDocumentParameters<AColor>()
    public var chevronColor = UploadDocumentParameters<AColor>()
    
    public var progressViewScheme: ProgressViewScheme
    public var chatBubbleStatusViewScheme: ChatBubbleStatusViewScheme

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
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
