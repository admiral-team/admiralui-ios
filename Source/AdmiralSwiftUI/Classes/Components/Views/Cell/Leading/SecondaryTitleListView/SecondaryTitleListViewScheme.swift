//
//  SecondaryTitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SecondaryTitleListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// Thebackground color of SecondaryTitleListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The text color of SecondaryTitleListView
    public var textColor = ControlParameter<AColor>()

    /// The title font of SecondaryTitleListView
    public var titleFont: AFont

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.headline
    }
}
