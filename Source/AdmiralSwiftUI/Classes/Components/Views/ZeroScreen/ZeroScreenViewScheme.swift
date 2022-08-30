//
//  ZeroScreenViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 05.08.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 ZeroScreenViewScheme - the visual scheme of BadgeView.
 You can create a by specifying the following parameters in init:
 - ZeroScreenViewScheme() - Initialize default ZeroScreenViewScheme with default themezation
 # Example to create ZeroScreenViewScheme:
 # Code
 ```
 let scheme = ZeroScreenViewScheme()
 ```
 */
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

    public init(
        titleColor: AColor,
        titleFont: AFont,
        subtitleColor: AColor,
        subtitleFont: AFont
    ) {
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
    }
}
