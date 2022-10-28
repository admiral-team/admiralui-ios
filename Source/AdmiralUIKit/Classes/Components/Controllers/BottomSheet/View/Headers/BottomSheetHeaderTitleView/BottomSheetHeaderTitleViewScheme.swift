//
//  BottomSheetHeaderTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 BottomSheetHeaderTitleViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BottomSheetHeaderTitleViewScheme() - Initialize default BottomSheetHeaderTitleViewScheme with default themezation
Example to create BottomSheetHeaderTitleViewScheme:
Code
 ```
let scheme = BottomSheetHeaderTitleViewScheme()
 ```
 */
public struct BottomSheetHeaderTitleViewScheme: AppThemeScheme {

    /// Text font.
    public var font: AFont

    /// Text color.
    public var textColor: AColor

    /// Background color.
    public var backgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        font = theme.fonts.title1
        
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundExtraSurface
    }
}
