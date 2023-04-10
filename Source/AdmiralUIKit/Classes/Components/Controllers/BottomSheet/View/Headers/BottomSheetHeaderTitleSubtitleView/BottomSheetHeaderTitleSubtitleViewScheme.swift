//
//  BottomSheetHeaderTitleSubtitleViewScheme.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 BottomSheetHeaderTitleSubtitleViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BottomSheetHeaderTitleSubtitleViewScheme() - Initialize default BottomSheetHeaderTitleSubtitleViewScheme with default themezation
Example to create BottomSheetHeaderTitleSubtitleViewScheme:
Code
 ```
let scheme = BottomSheetHeaderTitleSubtitleViewScheme()
 ```
 */
public struct BottomSheetHeaderTitleSubtitleViewScheme: AppThemeScheme {

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
