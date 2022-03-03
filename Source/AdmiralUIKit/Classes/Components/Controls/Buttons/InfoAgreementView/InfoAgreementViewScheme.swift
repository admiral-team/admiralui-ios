//
//  SegmentButtonsViewScheme.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct InfoAgreementViewScheme {
    
    var backgroundColor: AColor
    var checkBoxTextButtonViewTheme = CheckBoxTextButtonViewScheme()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        checkBoxTextButtonViewTheme = CheckBoxTextButtonViewScheme(theme: theme)
    }
}
