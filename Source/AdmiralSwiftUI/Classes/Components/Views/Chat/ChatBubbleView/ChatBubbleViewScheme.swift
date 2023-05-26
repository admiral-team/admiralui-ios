//
//  ChatBubbleViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
/**
 ChatBubbleViewScheme - the visual scheme of ChatBubbleView.
  You can create a by specifying the following parameters in init:
  - ChatBubbleViewScheme() - Initialize default StandardTabScheme with default themezation
  # Example to create ChatBubbleViewScheme:
  # Code
  ```
 let scheme = ChatBubbleViewScheme()
  ```
  */
@available(iOS 14.0, *)
public struct ChatBubbleViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The text font
    public var textFont: AFont

    /// The text color
    public var textColor = ChatBubbleViewParameters<AColor>()

    /// The background color
    public var backgroundColor = ChatBubbleViewParameters<AColor>()

    /// THe eror image tint color
    public var errorImageColor: AColor

    /// The font of name text label
    public var nameTextFont: AFont

    /// The color of name text label
    public var nameTextColor: AColor

    /// Scheme for status view.
    public var chatBubbleStatusScheme: ChatBubbleStatusViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor.set(parameter: theme.colors.textPrimary, style: .left)
        textColor.set(parameter: theme.colors.textStaticWhite, style: .right)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .left)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .right)
        
        errorImageColor = theme.colors.elementError

        textFont = theme.fonts.body1

        nameTextFont = theme.fonts.caption1
        nameTextColor = theme.colors.textSecondary

        chatBubbleStatusScheme = ChatBubbleStatusViewScheme(theme: theme)
    }

}

@available(iOS 14.0, *)
public struct ChatBubbleViewParameters<P> {
    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, style: ChatDirection) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

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
