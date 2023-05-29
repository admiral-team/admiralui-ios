//
//  SubtitleTitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
/**
 SubtitleTitleListViewScheme - the visual scheme of SubtitleTitleListView.
 You can create a by specifying the following parameters in init:
 - SubtitleTitleListViewScheme() - Initialize default SubtitleTitleListViewScheme with default themezation
 # Example to create SubtitleTitleListViewScheme:
 # Code
 ```
 let scheme = SubtitleTitleListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct SubtitleTitleListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The title label color
    public var titleColor = ControlParameter<AColor>()

    /// The subtitle label color
    public var subtitleColor = ControlParameter<AColor>()

    /// The title font label
    public var titleFont = TitleSubtitleListViewParameters<AFont>()

    /// The subtitle font
    public var subtitleFont = TitleSubtitleListViewParameters<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: nil)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .title)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .body)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .headline)
    }
}
