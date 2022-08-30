//
//  ChatBubbleViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ChatBubbleViewScheme - the visual scheme of ChatBubbleView.
  You can create a by specifying the following parameters in init:
  - ChatBubbleViewScheme() - Initialize default StandardTabScheme with default themezation
  - ChatBubbleViewScheme(
     textFont: AFont,
     textColorLeft: AColor,
     textColorRight: AColor,
     backgroundColorLeft: AColor,
     backgroundColorRight: AColor,
     nameTextFont: AFont,
     nameTextColor: AColor
    )
  # Example to create ChatBubbleViewScheme:
  # Code
  ```
 let scheme = ChatBubbleViewScheme()
  ```
  */
@available(iOS 14.0, *)
public struct ChatBubbleViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text font of ChatBubbleView
    public var textFont: AFont

    /// The text color of ChatBubbleView
    public var textColor = ChatBubbleViewParameters<AColor>()

    /// The background color of  ChatBubbleView
    public var backgroundColor = ChatBubbleViewParameters<AColor>()

    /// The font of name text label in ChatBubbleView
    public var nameTextFont: AFont

    /// The color of name text label in ChatBubbleView
    public var nameTextColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        textColor.set(parameter: theme.colors.textPrimary, style: .left)
        textColor.set(parameter: theme.colors.textStaticWhite, style: .right)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .left)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .right)

        textFont = theme.fonts.body1

        nameTextFont = theme.fonts.caption1
        nameTextColor = theme.colors.textSecondary
    }

    public init(
        textFont: AFont,
        textColorLeft: AColor,
        textColorRight: AColor,
        backgroundColorLeft: AColor,
        backgroundColorRight: AColor,
        nameTextFont: AFont,
        nameTextColor: AColor
    ) {
        textColor.set(parameter: textColorLeft, style: .left)
        textColor.set(parameter: textColorRight, style: .right)

        backgroundColor.set(parameter: backgroundColorLeft, style: .left)
        backgroundColor.set(parameter: backgroundColorRight, style: .right)

        self.textFont = textFont
        self.nameTextFont = nameTextFont
        self.nameTextColor = nameTextColor
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
