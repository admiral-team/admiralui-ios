//
//  ActivityIndicatorScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import UIKit
import AdmiralTheme

/**
 ActivityIndicatorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ActivityIndicatorScheme() - Initialize default ActivityIndicatorScheme with default themezation
Example to create ActivityIndicatorScheme:
Code
 ```
let scheme = ActivityIndicatorScheme()
 ```
 */
public struct ActivityIndicatorScheme: AppThemeScheme {

    /// Default color.
    public var defaultColor: AColor

    /// Contrast color.
    public var contrastColor: AColor
    
    public init(theme: AppTheme = .default) {
        defaultColor = theme.colors.backgroundAccent
        contrastColor = theme.colors.elementStaticWhite
    }

}
