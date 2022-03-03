//
//  PinCodeKeyboardCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct PinCodeKeyboardCustomScheme {

    var backgroundColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
