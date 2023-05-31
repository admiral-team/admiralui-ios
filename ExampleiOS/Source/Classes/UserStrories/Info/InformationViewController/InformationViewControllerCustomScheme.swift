//
//  InformationViewControllerCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme

struct InformationViewControllerCustomScheme {
    var titleLabelFont: AFont

    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        titleLabelFont = theme.fonts.body1
        titleLabelTextColor = theme.colors.textPrimary
    }
    
}
