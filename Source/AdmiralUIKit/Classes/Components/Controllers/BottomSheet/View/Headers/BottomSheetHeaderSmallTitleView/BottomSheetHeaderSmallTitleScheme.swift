//
//  BottomSheetHeaderSmallTitleScheme.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct BottomSheetHeaderSmallTitleScheme {
    var titleLabelFont: AFont
    var rightButtonFont: AFont
    var titleTextColor: AColor
    var rightButtonTextColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.body1
        rightButtonFont = theme.fonts.body2
        
        titleTextColor = theme.colors.textPrimary
        rightButtonTextColor = theme.colors.textAccent
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
