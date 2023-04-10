//
//  CheckBoxListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 CheckBoxListViewScheme - the visual scheme of CheckBoxListView.
 You can create a by specifying the following parameters in init:
 - CheckBoxListViewScheme() - Initialize default CheckBoxListViewScheme with default themezation
 # Example to create CheckBoxListViewScheme:
 # Code
 ```
 let scheme = CheckBoxListViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CheckBoxListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  checkbox visual scheme
    public var checkBoxScheme: CheckControlScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        checkBoxScheme = CheckControlScheme(theme: theme)
    }
}
