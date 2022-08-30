//
//  ChatInputScheme.swift
//  AdmiralSwiftUI
//
//  Created on 16.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
  ChatInputScheme - the visual scheme of ChatBubbleView.
   You can create a by specifying the following parameters in init:
   - ChatInputScheme() - Initialize default StandardTabScheme with default themezation
   - ChatInputScheme(
         textColor: AColor,
         placeholderColor: AColor,
         backgroundColorDisabled: AColor,
         backgroundColorNormal: AColor,
         backgroundColorSelected: AColor,
         backgroundColorHighlighted: AColor,
         tintColor: AColor,
         textFont: AFont,
         placeholderFont: AFont,
         imageTintColor: AColor
     )
   # Example to create ChatInputScheme:
   # Code
   ```
  let scheme = ChatInputScheme()
   ```
   */
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

    public init(theme: AppTheme = .default) {
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

    public init(
        textColor: AColor,
        placeholderColor: AColor,
        backgroundColorDisabled: AColor,
        backgroundColorNormal: AColor,
        backgroundColorSelected: AColor,
        backgroundColorHighlighted: AColor,
        tintColor: AColor,
        textFont: AFont,
        placeholderFont: AFont,
        imageTintColor: AColor
    ) {
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        backgroundColor.set(parameter: backgroundColorDisabled, for: .disabled)
        backgroundColor.set(parameter: backgroundColorNormal, for: .normal)
        backgroundColor.set(parameter: backgroundColorSelected, for: .selected)
        backgroundColor.set(parameter: backgroundColorHighlighted, for: .highlighted)

        self.tintColor = tintColor
        self.imageTintColor = imageTintColor

        self.textFont = textFont
        self.placeholderFont = placeholderFont
    }

}

