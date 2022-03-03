//
//  IconTabsSegmentControlScheme.swift
//  AdmiralUI
//
//  Created on 12.02.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct IconTabsSegmentControlScheme {

    var backgroundColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
