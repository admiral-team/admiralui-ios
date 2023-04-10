//
//  SubtitleTitleHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 SubtitleTitleHeaderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SubtitleTitleHeaderScheme() - Initialize default SubtitleTitleHeaderScheme with default themezation
Example to create SubtitleTitleHeaderScheme:
Code
 ```
let scheme = SubtitleTitleHeaderScheme()
 ```
 */
public struct SubtitleTitleHeaderScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Default title font.
    public var defaultTitleFont: AFont

    /// Title font.
    public var titleFont = TitleHeaderViewParameters<AFont>()

    /// Subtitle font.
    public var subtitleFont = TitleHeaderViewParameters<AFont>()

    /// Title color.
    public var titleColor = TitleHeaderViewParameters<AColor>()

    /// Subtitle color.
    public var subtitleColor = TitleHeaderViewParameters<AColor>()

    public init(theme: AppTheme = .default) {
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
