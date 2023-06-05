//
//  CountDownTimerViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.12.2021.
//

import UIKit
import AdmiralTheme

/**
 CountDownTimerViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CountDownTimerViewScheme() - Initialize default CountDownTimerViewScheme with default themezation
Example to create CountDownTimerViewScheme:
Code
 ```
let scheme = CountDownTimerViewScheme()
 ```
 */
public struct CountDownTimerViewScheme: AppThemeScheme {

    /// Title text color.
    public var titleTextColor: AColor

    /// Title text font.
    public var titleTextFont: AFont

    /// Tint color.
    public var tintColor: AColor
    
    public init(theme: AppTheme = .default) {
        titleTextColor = theme.colors.textAccent
        titleTextFont = theme.fonts.subhead3
        
        tintColor = theme.colors.elementAccent
    }
    
}

