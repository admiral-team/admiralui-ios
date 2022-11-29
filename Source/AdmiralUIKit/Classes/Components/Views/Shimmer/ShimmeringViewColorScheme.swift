//
//  ShimmeringViewColorTheme.swift
//  AdmiralUI
//
//  Created on 17.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 ShimmeringViewColorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ShimmeringViewColorScheme() - Initialize default ShimmeringViewColorScheme with default themezation
Example to create ShimmeringViewColorScheme:
Code
 ```
let scheme = ShimmeringViewColorScheme()
 ```
 */
public struct ShimmeringViewColorScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundAdditionalOne
    }
    
}
