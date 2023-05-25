//
//  PinCodeKeyboardCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme

/**
 PinCodeKeyboardCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinCodeKeyboardCustomScheme() - Initialize default PinCodeKeyboardCustomScheme with default themezation
Example to create PinCodeKeyboardCustomScheme:
Code
 ```
let scheme = PinCodeKeyboardCustomScheme()
 ```
 */
public struct PinCodeKeyboardCustomScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
