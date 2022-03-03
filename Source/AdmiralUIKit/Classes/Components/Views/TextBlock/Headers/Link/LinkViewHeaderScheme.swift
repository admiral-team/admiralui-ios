//
//  LinkViewScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct LinkViewHeaderScheme {
    
    var backgroundColor: AColor
    var ghostScheme: GhostButtonCustomScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        ghostScheme = GhostButtonCustomScheme(theme: theme)
    }
}

