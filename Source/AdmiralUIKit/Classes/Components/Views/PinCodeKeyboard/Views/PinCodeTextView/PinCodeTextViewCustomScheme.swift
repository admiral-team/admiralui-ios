//
//  PinCodeTextViewCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct PinCodeTextViewCustomScheme {
    
    var backgroundColor: AColor
    var textColor: AColor
    var textFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textFont = theme.fonts.subtitle3
        textColor = theme.colors.textSecondary
    }
    
}
