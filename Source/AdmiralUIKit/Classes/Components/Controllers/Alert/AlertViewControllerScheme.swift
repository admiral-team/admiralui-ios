//
//  AlertViewControllerScheme.swift
//  AdmiralUIKit
//
//  Created on 31.01.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct AlertViewControllerScheme {
    
    var backgroundColor: AColor
    var defaultAlertViewCustomScheme: DefaultAlertViewCustomScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundModalView.withAlpha(alpha)
        defaultAlertViewCustomScheme = DefaultAlertViewCustomScheme(theme: theme)
    }
    
}
