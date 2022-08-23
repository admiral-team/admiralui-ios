//
//  ZeroScreenViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 05.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ZeroScreenViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title color of ZeroScreenView
    public var titleColor: AColor

    /// The title font of ZeroScreenView
    public var titleFont: AFont

    /// The subtitle color of ZeroScreenView
    public var subtitleColor: AColor

    /// The subtitle font of ZeroScreenView
    public var subtitleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.title1

        subtitleColor = theme.colors.textSecondary
        subtitleFont = theme.fonts.body2
    }
}
