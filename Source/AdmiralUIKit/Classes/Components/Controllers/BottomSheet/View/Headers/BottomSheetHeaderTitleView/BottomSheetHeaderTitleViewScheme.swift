//
//  BottomSheetHeaderTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct BottomSheetHeaderTitleViewScheme {
    var font: AFont
    var textColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        font = theme.fonts.title1
        
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
