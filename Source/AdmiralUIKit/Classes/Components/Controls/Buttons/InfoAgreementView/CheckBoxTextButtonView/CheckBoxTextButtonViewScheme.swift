//
//  CheckBoxTextButtonViewTheme.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme

struct CheckBoxTextButtonViewScheme {
    
    var backgroundColor: UIColor
    var checkTextControl = CheckTextControlScheme()
    var primaryLinkScheme = TagControlCustomScheme()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = .clear
        checkTextControl = CheckTextControlScheme(theme: theme)
        primaryLinkScheme = TagControlCustomScheme(theme: theme)
    }
}
