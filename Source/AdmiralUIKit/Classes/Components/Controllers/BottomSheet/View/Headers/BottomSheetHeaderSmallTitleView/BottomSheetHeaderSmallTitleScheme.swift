//
//  BottomSheetHeaderSmallTitleScheme.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 BottomSheetHeaderSmallTitleScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BottomSheetHeaderSmallTitleScheme() - Initialize default BottomSheetHeaderSmallTitleScheme with default themezation
Example to create BottomSheetHeaderSmallTitleScheme:
Code
 ```
let scheme = BottomSheetHeaderSmallTitleScheme()
 ```
 */
public struct BottomSheetHeaderSmallTitleScheme: AppThemeScheme {

    /// Title label font.
    public var titleLabelFont: AFont

    /// Right button font.
    public var rightButtonFont: AFont

    /// Title text color.
    public var titleTextColor: AColor

    /// Right button text color.
    public var rightButtonTextColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    public init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.body1
        rightButtonFont = theme.fonts.body2
        
        titleTextColor = theme.colors.textPrimary
        rightButtonTextColor = theme.colors.textAccent
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
