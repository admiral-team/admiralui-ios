//
//  SwiftUIContentViewScheme.swift
//  ExampleiOS
//
//  Created on 21.05.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources
import Combine

@available(iOS 14.0.0, *)
public struct SwiftUIContentViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var titleNavigationColor: AColor
    public var textColor: AColor
    public var textFont: AFont
    public var backButtonColor: AColor
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        titleNavigationColor = theme.colors.textPrimary
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.headline
        backButtonColor = theme.colors.elementAccent
    }
    
}
