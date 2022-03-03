//
//  SubtitleTitleHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct SubtitleTitleHeaderScheme {
    
    var backgroundColor: AColor
    var defaultTitleFont: AFont
    var titleFont = TitleHeaderViewParameters<AFont>()
    var subtitleFont = TitleHeaderViewParameters<AFont>()
    var titleColor = TitleHeaderViewParameters<AColor>()
    var subtitleColor = TitleHeaderViewParameters<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: nil)
        titleColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal, style: nil)
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled, style: nil)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: nil)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .title)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .body)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .headline)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .headlineSecondary)
        
        defaultTitleFont = theme.fonts.body1
    }
}
