//
//  OnBoardingViewControllerCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct OnBoardingViewControllerCustomScheme {
    
    var titleLabelFont: AFont
    var titleLabelTextColor: AColor
    var subtitleLabelFont: AFont
    var subtitleLabelTextColor: AColor
    var backgroundViewColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.largeTitle1
        titleLabelTextColor = theme.colors.textPrimary
        subtitleLabelFont = theme.fonts.body2
        subtitleLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
        backgroundViewColor = theme.colors.backgroundSelected
    }

}
