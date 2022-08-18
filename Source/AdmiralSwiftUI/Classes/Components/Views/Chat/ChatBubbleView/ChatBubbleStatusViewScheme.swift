//
//  ChatBubbleStatusViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct ChatBubbleStatusViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text font of ChatBubbleStatusViewScheme
    public var textFont: AFont

    /// The text color of ChatBubbleStatusViewScheme
    public var textColor = ChatBubbleStatusViewParameters<AColor>()

    /// The image color of ChatBubbleStatusViewScheme
    public var imageColor = ChatBubbleStatusViewParameters<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
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

public struct ChatBubbleStatusViewParameters<P> {

    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, status: ChatStatus, direction: ChatDirection, style: ChatBubbleStatusStyle) {
        let key = paramKey(status: status, direction: direction, style: style)
        parameters[key] = parameter
    }

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
