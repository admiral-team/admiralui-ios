//
//  ImageNameListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageNameListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ImageNameListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The background name color of ImageNameListView
    public var backgroundNameViewColor = ControlParameter<AColor>()

    /// The title label color of ImageNameListView
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The title font of ImageNameListView
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
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
