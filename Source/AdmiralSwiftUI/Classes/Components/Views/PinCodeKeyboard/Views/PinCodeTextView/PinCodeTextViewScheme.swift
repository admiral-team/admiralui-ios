//
//  PinCodeTextViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinCodeTextViewScheme - the visual scheme of PinCodeTextView.
 You can create a by specifying the following parameters in init:
 - PinCodeTextViewScheme() - Initialize default PinCodeTextViewScheme with default themezation
 - PinCodeTextViewScheme(
 backgroundColorNormal: AColor,
 backgroundColorHighlighted: AColor,
 imageColor: AColor,
 textColor: AColor,
 textFont: AFont
 )
 # Example to create PinCodeTextViewScheme:
 # Code
 ```
 let scheme = PinCodeTextViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PinCodeTextViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PinCodeTextView
    public var backgroundColor: AColor

    /// The text color of PinCodeTextView
    public var textColor: AColor

    /// The text font of PinCodeTextView
    public var textFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.body2
    }

    public init(
        backgroundColor: AColor,
        textColor: AColor,
        textFont: AFont
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.textFont = textFont
    }

}
