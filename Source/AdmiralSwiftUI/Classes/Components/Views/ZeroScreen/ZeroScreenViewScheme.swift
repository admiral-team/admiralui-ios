//
//  ZeroScreenViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 05.08.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 ZeroScreenViewScheme - the visual scheme of ZeroScreenView.
 You can create a by specifying the following parameters in init:
 - ZeroScreenViewScheme() - Initialize default ZeroScreenViewScheme with default themezation
 # Example to create ZeroScreenViewScheme:
 # Code
 ```
 let scheme = ZeroScreenViewScheme()
 ```
 */
public struct ZeroScreenViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title color
    public var titleColor: AColor

    /// The title font
    public var titleFont: AFont

    /// The subtitle color
    public var subtitleColor: AColor

    /// The subtitle font
    public var subtitleFont: AFont

    /// Button scheme
    public var buttonScheme: PrimaryButtonScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.title1

        subtitleColor = theme.colors.textSecondary
        subtitleFont = theme.fonts.body2

        buttonScheme = PrimaryButtonScheme(theme: theme)
    }

}
