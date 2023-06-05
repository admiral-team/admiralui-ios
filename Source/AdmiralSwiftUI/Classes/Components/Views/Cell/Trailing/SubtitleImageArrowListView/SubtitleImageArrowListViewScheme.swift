//
//  SubtitleImageArrowListViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import AdmiralTheme
/**
 SubtitleWithImageListViewScheme - the visual scheme of SubtitleImageArrowListView.
 You can create a by specifying the following parameters in init:
 - SubtitleWithImageListViewScheme() - Initialize default SubtitleWithImageListViewScheme with default themezation
 # Example to create SubtitleWithImageListViewScheme:
 # Code
 ```
 let scheme = SubtitleWithImageListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct SubtitleImageArrowListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageTintColor = ControlParameter<AColor>()

    /// The  parameter that sets image view aplha with state
    public var imageViewAlpha = ControlParameter<Double>()

    /// The  parameter that sets subtitle labe text color with state
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets arrow image tint color with state
    public var arrowTintColor = ControlParameter<AColor>()

    /// The subtitle font
    public var subtitleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        arrowTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        arrowTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleFont = theme.fonts.subhead3
    }
}


