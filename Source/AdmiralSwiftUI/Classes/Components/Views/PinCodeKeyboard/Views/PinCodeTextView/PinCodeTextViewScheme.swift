//
//  PinCodeTextViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

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

    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subtitle3
    }
    
}
