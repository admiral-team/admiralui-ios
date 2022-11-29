//
//  SubtitleWithImageListViewScheme.swift
//  AdmiralUI
//
//  Created on 04.03.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleWithImageListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SubtitleWithImageListViewScheme() - Initialize default SubtitleWithImageListViewScheme with default themezation
Example to create SubtitleWithImageListViewScheme:
Code
 ```
let scheme = SubtitleWithImageListViewScheme()
 ```
 */
public struct SubtitleWithImageListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image tint color.
    public var imageTintColor = ControlParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// Subtitle font.
    public var subtitleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        subtitleFont = theme.fonts.subhead3
    }
}
