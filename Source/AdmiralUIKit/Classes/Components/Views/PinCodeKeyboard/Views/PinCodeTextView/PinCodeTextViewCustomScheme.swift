//
//  PinCodeTextViewCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 PinCodeTextViewCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinCodeTextViewCustomScheme() - Initialize default PinCodeTextViewCustomScheme with default themezation
Example to create PinCodeTextViewCustomScheme:
Code
 ```
let scheme = PinCodeTextViewCustomScheme()
 ```
 */
public struct PinCodeTextViewCustomScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Text color.
    public var textColor: AColor

    /// Text font.
    public var textFont: AFont

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        textFont = theme.fonts.subtitle3
        textColor = theme.colors.textSecondary
    }
    
}
