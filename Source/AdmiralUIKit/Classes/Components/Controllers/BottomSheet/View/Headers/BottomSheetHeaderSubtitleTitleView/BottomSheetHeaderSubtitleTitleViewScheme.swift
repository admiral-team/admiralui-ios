//
//  BottomSheetHeaderSubtitleTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 BottomSheetHeaderSubtitleTitleViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BottomSheetHeaderSubtitleTitleViewScheme() - Initialize default BottomSheetHeaderSubtitleTitleViewScheme with default themezation
Example to create BottomSheetHeaderSubtitleTitleViewScheme:
Code
 ```
let scheme = BottomSheetHeaderSubtitleTitleViewScheme()
 ```
 */
public struct BottomSheetHeaderSubtitleTitleViewScheme: AppThemeScheme {

    /// Title label font.
    public var titleLabelFont: AFont

    /// Subtitle label font.
    public var subtitleLabelFont: AFont

    /// Title text color.
    public var titleTextColor: AColor

    /// Subtitle text color.
    public var subtitleTextColor: AColor

    /// Background color.
    public var backgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.title1
        subtitleLabelFont = theme.fonts.body1
        
        titleTextColor = theme.colors.textPrimary
        subtitleTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
