//
//  BadgesSwiftUIViewScheme.swift
//  ExampleiOS
//
//  Created on 06.08.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import Combine

@available(iOS 14.0.0, *)
public struct BadgesSwiftUIViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var titleNavigationColor: AColor
    public var textColor: AColor
    public var textFont: AFont
    public var imageTintColor: AColor
    public var backgroundImageColor: AColor
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        titleNavigationColor = theme.colors.textPrimary
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.headline
        imageTintColor = theme.colors.elementAccent
        backgroundImageColor = theme.colors.backgroundAdditionalOne
    }
    
}
