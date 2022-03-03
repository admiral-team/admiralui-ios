//
//  PaddingViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SeparatorViewScheme: AppThemeScheme {
    
    public var lineTintColor: AColor
    
    public init(theme: AppTheme) {
        lineTintColor = theme.colors.elementAdditional
    }
}
