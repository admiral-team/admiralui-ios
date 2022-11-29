//
//  ToolbarColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 ToolbarColorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ToolbarColorScheme() - Initialize default ToolbarColorScheme with default themezation
Example to create ToolbarColorScheme:
Code
 ```
let scheme = ToolbarColorScheme()
 ```
 */
public struct ToolbarColorScheme: AppThemeScheme {
    
    /// Background color.
    public var backgroundColor: AColor
    
    /// Shadow color.
    public var shadowColor: AColor
    
    /// Item color scheme.
    public var itemColorScheme: ToolbarItemColorScheme

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundAccentDark
        shadowColor = theme.colors.backgroundShadow
        itemColorScheme = ToolbarItemColorScheme(theme: theme)
    }
    
}
