//
//  ArrowWithButtonHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct ArrowWithButtonHeaderScheme {
    
    var backgroundColor: AColor
    var defaultTitleFont: AFont
    var titleFont = TitleHeaderViewParameters<AFont>()
    var textColor = TitleHeaderViewParameters<AColor>()
    var imageTintColor: AColor
    var ghostButtonScheme: GhostButtonCustomScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: nil)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        imageTintColor = theme.colors.elementPrimary
        
        ghostButtonScheme = GhostButtonCustomScheme(theme: theme)
        
        defaultTitleFont = theme.fonts.body1
    }
}
