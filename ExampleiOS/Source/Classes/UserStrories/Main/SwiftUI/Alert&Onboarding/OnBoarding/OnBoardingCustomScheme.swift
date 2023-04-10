//
//  OnBoardingCustomScheme.swift
//  ExampleiOS
//
//  Created on 08.04.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct OnBoardingCustomScheme: AppThemeScheme {
    
    var titleLabelFont: AFont
    var descriptionLabelTextFont: AFont
    var buttonFont: AFont
    
    var titleLabelColor: AColor
    var descriptionLabelTextColor: AColor
    var imageBackground: AColor
    var buttonColor: AColor
    var backgroundColor: AColor
    
    public init(theme: AppTheme) {
        titleLabelFont = theme.fonts.largeTitle1
        descriptionLabelTextFont = theme.fonts.body2
        buttonFont = theme.fonts.body2
        
        titleLabelColor = theme.colors.textPrimary
        descriptionLabelTextColor = theme.colors.textSecondary
        imageBackground = theme.colors.backgroundSelected
        buttonColor = theme.colors.elementAccent
        backgroundColor = theme.colors.backgroundBasic
    }
}
