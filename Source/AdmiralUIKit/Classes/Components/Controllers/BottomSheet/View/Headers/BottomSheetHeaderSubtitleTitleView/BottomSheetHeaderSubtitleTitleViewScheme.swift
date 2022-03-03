//
//  BottomSheetHeaderSubtitleTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct BottomSheetHeaderSubtitleTitleViewScheme {
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    var titleTextColor: AColor
    var subtitleTextColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.title1
        subtitleLabelFont = theme.fonts.body1
        
        titleTextColor = theme.colors.textPrimary
        subtitleTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
