//
//  ChatInputScheme.swift
//  AdmiralSwiftUI
//
//  Created on 16.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct ChatInputScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of ChatInput
    public var textColor: AColor

    /// The placeholder color of ChatInput
    public var placeholderColor: AColor

    /// The background color of ChatInput
    public var backgroundColor = ControlParameter<AColor>()

    /// The tint color of ChatInput
    public var tintColor: AColor

    /// The text font of ChatInput
    public var textFont: AFont

    /// The placeholder font of ChatInput
    public var placeholderFont: AFont

    /// The image tint color of ChatInput
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .selected)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .highlighted)

        tintColor = theme.colors.elementAccent
        imageTintColor = theme.colors.elementPrimary

        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }

}
