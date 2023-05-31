//
//  ChatBubbleStatusViewScheme.swift
//  AdmiralUIKit
//
//  Created on 03.12.2021.
//

import AdmiralTheme

/**
 ChatBubbleStatusViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ChatBubbleStatusViewScheme() - Initialize default ChatBubbleStatusViewScheme with default themezation
Example to create ChatBubbleStatusViewScheme:
Code
 ```
let scheme = ChatBubbleStatusViewScheme()
 ```
 */
public struct ChatBubbleStatusViewScheme: AppThemeScheme {

    /// Text font.
    public var textFont: AFont

    /// Text color.
    public var textColor = ChatBubbleStatusViewParameters<AColor>()

    /// Image color.
    public var imageColor = ChatBubbleStatusViewParameters<AColor>()

    public init(theme: AppTheme = .default) {
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .loading, direction: .right, style: .default)
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .error, direction: .right, style: .default)
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .sent, direction: .right, style: .default)
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .receive, direction: .right, style: .default)
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .read, direction: .right, style: .default)
        textColor.set(parameter: theme.colors.textAccentAdditional, status: .none, direction: .right, style: .default)

        textColor.set(parameter: theme.colors.elementStaticWhite, status: .loading, direction: .right, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .error, direction: .right, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .sent, direction: .right, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .receive, direction: .right, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .read, direction: .right, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .none, direction: .right, style: .light)

        textColor.set(parameter: theme.colors.textSecondary, status: .loading, direction: .left, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, status: .error, direction: .left, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, status: .sent, direction: .left, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, status: .receive, direction: .left, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, status: .read, direction: .left, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, status: .none, direction: .left, style: .default)

        textColor.set(parameter: theme.colors.elementStaticWhite, status: .loading, direction: .left, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .error, direction: .left, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .sent, direction: .left, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .receive, direction: .left, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .read, direction: .left, style: .light)
        textColor.set(parameter: theme.colors.elementStaticWhite, status: .none, direction: .left, style: .light)

        textFont = theme.fonts.caption1

        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .loading, direction: .right, style: .default)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .error, direction: .right, style: .default)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .sent, direction: .right, style: .default)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .receive, direction: .right, style: .default)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .read, direction: .right, style: .default)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .none, direction: .right, style: .default)

        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .loading, direction: .right, style: .light)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .error, direction: .right, style: .light)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .sent, direction: .right, style: .light)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .receive, direction: .right, style: .light)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .read, direction: .right, style: .light)
        imageColor.set(parameter: theme.colors.elementStaticWhite, status: .none, direction: .right, style: .light)
    }

}

/// A container for setting value for difference state.
public struct ChatBubbleStatusViewParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - status: Chat status.
    ///   - direction: Chat direction.
    ///   - style: Chat bubble status style.
    public mutating func set(parameter: P?, status: ChatStatus, direction: ChatDirection, style: ChatBubbleStatusStyle) {
        let key = paramKey(status: status, direction: direction, style: style)
        parameters[key] = parameter
    }


    /// Getting parameter.
    /// - Parameters:
    ///   - status: Chat status.
    ///   - direction:  Chat direction.
    ///   - style: Chat bubble status style.
    /// - Returns: Any value.
    public func parameter(for status: ChatStatus, direction: ChatDirection, style: ChatBubbleStatusStyle) -> P? {
        let key = paramKey(status: status, direction: direction, style: style)
        let defaultKey = paramKey(status: status, direction: direction, style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(
        status: ChatStatus,
        direction: ChatDirection,
        style: ChatBubbleStatusStyle
    ) -> String {
        return "\(status.rawValue).\(direction.rawValue).\(style.rawValue)"
    }

}
