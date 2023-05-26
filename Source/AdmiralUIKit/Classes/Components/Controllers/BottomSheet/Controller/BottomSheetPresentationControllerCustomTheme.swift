//
//  BottomSheetPresentationControllerCustomTheme.swift
//  AdmiralUI
//
//  Created on 20.01.2021.
//

import AdmiralTheme

/**
 BottomSheetPresentationControllerCustomTheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BottomSheetPresentationControllerCustomTheme() - Initialize default BottomSheetPresentationControllerCustomTheme with default themezation
Example to create BottomSheetPresentationControllerCustomTheme:
Code
 ```
let scheme = BottomSheetPresentationControllerCustomTheme()
 ```
 */
public struct BottomSheetPresentationControllerCustomTheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundExtraSurface
    }
    
}
