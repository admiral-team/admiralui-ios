//
//  CheckBoxListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CheckBoxListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var checkBoxTintColor = ControlParameter<AColor>()
    
    var checkBoxScheme = CheckTextControlScheme()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        checkBoxTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        checkBoxTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        checkBoxScheme = CheckTextControlScheme(theme: theme)
    }
}
