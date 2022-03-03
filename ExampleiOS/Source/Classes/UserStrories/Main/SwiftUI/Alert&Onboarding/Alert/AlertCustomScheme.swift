//
//  AlertCustomScheme.swift
//  ExampleiOS
//
//  Created on 11.01.2022.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct AlertCustomScheme: AppThemeScheme {
    
    var descriptionLabelFont: AFont
    var descriptionLabelTextColor: AColor
    var backgroundColor: AColor
    var backBackgroundColor: AColor
    
    public init(theme: AppTheme) {
        descriptionLabelTextColor = theme.colors.textPrimary
        descriptionLabelFont = theme.fonts.body2
        backgroundColor = theme.colors.backgroundBasic
        backBackgroundColor = theme.colors.backgroundModalView
    }
}
