//
//  SeparatorScheme.swift
//  AdmiralUIKit
//
//  Created on 12.07.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct SeparatorScheme {
    var backgroundColor: AColor
    var separatorColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        separatorColor = theme.colors.elementAdditional
    }
}
