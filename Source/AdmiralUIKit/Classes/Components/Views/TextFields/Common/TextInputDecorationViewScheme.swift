//
//  TextInputDecorationViewScheme.swift
//  AdmiralUIKit
//
//  Created on 19.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct TextInputDecorationViewScheme {
    
    var nameFont: AFont
    var placeholderFont: AFont
    var informerFont: AFont
    var nameLabelMinFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        nameFont = theme.fonts.subhead3
        placeholderFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
        nameLabelMinFont = theme.fonts.subhead3
    }
    
}
