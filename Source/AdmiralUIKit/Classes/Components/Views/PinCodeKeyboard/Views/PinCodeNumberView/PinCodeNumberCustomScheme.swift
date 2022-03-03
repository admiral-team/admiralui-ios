//
//  PinCodeNumberCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct PinCodeNumberCustomScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var imageColor: AColor
    var textColor: AColor
    var textFont: UIFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        
        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        textFont = UIFont.systemFont(ofSize: 32.0)
    }
    
}


