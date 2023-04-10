//
//  NavigationContentViewScheme.swift
//  ExampleiOS
//
//  Created on 04.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct NavigationContentViewScheme: AppThemeScheme {
    
    public var backButtonColor: AColor
    
    public init(theme: AppTheme) {
        backButtonColor = theme.colors.elementAccent
    }
    
}
