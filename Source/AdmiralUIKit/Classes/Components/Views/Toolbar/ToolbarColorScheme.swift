//
//  ToolbarColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct ToolbarColorScheme {
    
    /// Background color
    public var backgroundColor: AColor
    
    /// Shadow color
    public var shadowColor: AColor
    
    /// Item color scheme
    public var itemColorScheme: ToolbarItemColorScheme

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundAccentDark
        shadowColor = theme.colors.backgroundShadow
        itemColorScheme = ToolbarItemColorScheme(theme: theme)
    }
    
}
