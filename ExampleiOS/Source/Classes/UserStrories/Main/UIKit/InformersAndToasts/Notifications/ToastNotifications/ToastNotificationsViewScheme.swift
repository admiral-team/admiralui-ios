//
//  ToastNotificationsViewScheme.swift
//  ExampleiOS
//
//  Created on 24.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct ToastNotificationsViewScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.body2
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
}
