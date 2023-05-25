//
//  ChatBubbleViewScheme.swift
//  AdmiralUIKit
//
//  Created on 03.12.2021.
//

import AdmiralTheme

/**
 ChatBubbleViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ChatBubbleViewScheme() - Initialize default ChatBubbleViewScheme with default themezation
Example to create ChatBubbleViewScheme:
Code
 ```
let scheme = ChatBubbleViewScheme()
 ```
 */
public struct ChatBubbleViewScheme: AppThemeScheme {

    /// Text font.
    public var textFont: AFont

    /// Text color.
    public var textColor = ChatBubbleViewParameters<AColor>()

    /// Background color.
    public var backgroundColor = ChatBubbleViewParameters<AColor>()

    /// Rrror image color.
    public var errorImageColor: AColor

    /// Name text font.
    public var nameTextFont: AFont

    /// Name text color.
    public var nameTextColor: AColor

    public init(theme: AppTheme = .default) {
        textColor.set(parameter: theme.colors.textPrimary, style: .left)
        textColor.set(parameter: theme.colors.textStaticWhite, style: .right)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .left)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .right)
        
        errorImageColor = theme.colors.elementError

        textFont = theme.fonts.body1

        nameTextFont = theme.fonts.caption1
        nameTextColor = theme.colors.textSecondary
    }

}

/// A container for setting value for difference state.
public struct ChatBubbleViewParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style chat direction.
    public mutating func set(parameter: P?, style: ChatDirection) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style chat direction.
    /// - Returns: Any value.
    public func parameter(for style: ChatDirection) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ChatDirection) -> String {
        return "\(style.rawValue)"
    }

}
