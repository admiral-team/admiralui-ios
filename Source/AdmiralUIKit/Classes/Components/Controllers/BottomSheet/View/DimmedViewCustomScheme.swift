//
//  DimmedViewCustomScheme.swift
//  AdmiralUI
//
//  Created on 22.01.2021.
//

import AdmiralTheme

/**
 DimmedViewCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DimmedViewCustomScheme() - Initialize default DimmedViewCustomScheme with default themezation
Example to create DimmedViewCustomScheme:
Code
 ```
let scheme = DimmedViewCustomScheme()
 ```
 */
public struct DimmedViewCustomScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundModalView.withAlpha(theme.colors.disabledAlpha)
    }
    
}
