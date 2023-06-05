//
//  SecondaryTitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
/**
 SecondaryTitleListViewScheme - the visual scheme of SecondaryTitleListView.
 You can create a by specifying the following parameters in init:
 - SecondaryTitleListViewScheme() - Initialize default SecondaryTitleListViewScheme with default themezation
 # Example to create SecondaryTitleListViewScheme:
 # Code
 ```
 let scheme = SecondaryTitleListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct SecondaryTitleListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets text color with state
    public var textColor = ControlParameter<AColor>()

    /// The  title font
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.headline
    }
}
