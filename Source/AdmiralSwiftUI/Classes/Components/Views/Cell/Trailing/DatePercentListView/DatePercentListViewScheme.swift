//
//  DatePercentListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 DatePercentListViewScheme - the visual scheme of DatePercentListView.
 You can create a by specifying the following parameters in init:
 - DatePercentListViewScheme() - Initialize default DatePercentListViewScheme with default themezation
 # Example to create DatePercentListViewScheme:
 # Code
 ```
 let scheme = DatePercentListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct DatePercentListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets title label color with state
    public var titleColor = ControlParameter<AColor>()

    /// The  parameter that sets subtitle color label with state
    public var subtitleColor = ControlParameter<AColor>()

    /// The  title font label
    public var titleFont: AFont

    /// The subtitle font label
    public var subtitleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.subhead3
        subtitleFont = theme.fonts.subhead3
    }
}
