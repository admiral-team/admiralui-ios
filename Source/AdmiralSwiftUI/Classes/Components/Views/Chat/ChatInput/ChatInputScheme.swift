//
//  ChatInputScheme.swift
//  AdmiralSwiftUI
//
//  Created on 16.08.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ChatInputScheme - the visual scheme of ChatBubbleView.
 You can create a by specifying the following parameters in init:
 - ChatInputScheme() - Initialize default StandardTabScheme with default themezation
 # Example to create ChatInputScheme:
 # Code
 ```
 let scheme = ChatInputScheme()
 ```
 */
public struct ChatInputScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color
    public var textColor: AColor

    /// The placeholder color
    public var placeholderColor: AColor

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The tint color
    public var tintColor: AColor

    /// The text font
    public var textFont: AFont

    /// The placeholder font
    public var placeholderFont: AFont

    /// The image tint color
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

}

