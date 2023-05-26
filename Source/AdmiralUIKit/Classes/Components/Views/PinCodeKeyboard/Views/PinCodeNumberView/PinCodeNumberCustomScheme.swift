//
//  PinCodeNumberCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme

/**
 PinCodeNumberCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinCodeNumberCustomScheme() - Initialize default PinCodeNumberCustomScheme with default themezation
Example to create PinCodeNumberCustomScheme:
Code
 ```
let scheme = PinCodeNumberCustomScheme()
 ```
 */
public struct PinCodeNumberCustomScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image color.
    public var imageColor: AColor

    /// Text color.
    public var textColor: AColor

    /// Text font.
    public var textFont: UIFont

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        
        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        textFont = UIFont.systemFont(ofSize: 32.0)
    }
    
}


