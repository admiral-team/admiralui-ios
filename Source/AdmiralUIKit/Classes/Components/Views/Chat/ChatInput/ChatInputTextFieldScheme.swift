//
//  ChatInputTextFieldScheme.swift
//  AdmiralUIResources
//
//  Created on 24.11.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

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
public struct ChatInputTextFieldScheme: AppThemeScheme {

    /// Tint color.
    public var tintColor = ChatInputTextFieldParameters<AColor>()

    /// Text color.
    public var textColor = ChatInputTextFieldParameters<AColor>()

    /// Placeholder color.
    public var placeholderColor = ChatInputTextFieldParameters<AColor>()

    /// Text field background color.
    public var textFieldBackgroundColor = ChatInputTextFieldParameters<AColor>()

    /// Image tint color.
    public var imageTintColor: AColor

    /// Text field font.
    public var textFieldFont: AFont

    /// Placeholder font.
    public var placeholderFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        imageTintColor = theme.colors.elementPrimary

        tintColor.set(parameter: theme.colors.elementAccent, state: .normal)
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), state: .disabled)
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), state: .readOnly)
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), state: .error)

        textColor.set(parameter: theme.colors.textPrimary, state: .normal)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), state: .disabled)
        tintColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), state: .readOnly)
        tintColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), state: .error)

        placeholderColor.set(parameter: theme.colors.textSecondary, state: .normal)
        placeholderColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), state: .disabled)
        placeholderColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), state: .readOnly)
        placeholderColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), state: .error)

        textFieldBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), state: .disabled)
        textFieldBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, state: .normal)
        textFieldBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), state: .readOnly)
        textFieldBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), state: .error)

        textFieldFont = theme.fonts.body1
        placeholderFont = theme.fonts.body1
    }

}

/// A container for setting value for difference state.
public struct ChatInputTextFieldParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: Text input state.
    public mutating func set(parameter: P?, state: TextInputState) {
        let key = paramKey(state: state)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: Text input state.
    /// - Returns: Any value.
    public func parameter(for state: TextInputState) -> P? {
        let key = paramKey(state: state)
        let defaultKey = paramKey(state: state)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(state: TextInputState) -> String {
        return "\(state.rawValue)"
    }

}

