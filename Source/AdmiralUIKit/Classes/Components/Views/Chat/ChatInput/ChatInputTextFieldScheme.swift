//
//  ChatInputTextFieldScheme.swift
//  AdmiralUIResources
//
//  Created on 24.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct ChatInputTextFieldScheme {

    var tintColor = ChatInputTextFieldParameters<AColor>()
    var textColor = ChatInputTextFieldParameters<AColor>()
    var placeholderColor = ChatInputTextFieldParameters<AColor>()
    var textFieldBackgroundColor = ChatInputTextFieldParameters<AColor>()
    var imageTintColor: AColor

    var textFieldFont: AFont
    var placeholderFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
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

public struct ChatInputTextFieldParameters<P> {
    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, state: TextInputState) {
        let key = paramKey(state: state)
        parameters[key] = parameter
    }

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

