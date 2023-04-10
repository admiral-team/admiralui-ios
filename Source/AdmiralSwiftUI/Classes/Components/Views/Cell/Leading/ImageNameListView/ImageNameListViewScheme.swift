//
//  ImageNameListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ImageNameListViewScheme - the visual scheme of ImageNameListView.
 You can create a by specifying the following parameters in init:
 - ImageNameListViewScheme() - Initialize default ImageNameListViewScheme with default themezation
 # Example to create ImageNameListViewScheme:
 # Code
 ```
 let scheme = ImageNameListViewScheme()
 ```
 */
public struct ImageNameListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The background color
    public var backgroundNameViewColor = ControlParameter<AColor>()

    /// The title label text color
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The title label font
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
        
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary, for: .normal)
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary.withAlpha(alpha), for: .disabled)
        titleFont = theme.fonts.subhead1
    }
}
