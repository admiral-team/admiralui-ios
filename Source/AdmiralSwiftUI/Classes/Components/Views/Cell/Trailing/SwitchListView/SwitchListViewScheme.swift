//
//  SwitchListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
/**
 SwitchListViewScheme - the visual scheme of SwitchListView.
 You can create a by specifying the following parameters in init:
 - SwitchListViewScheme() - Initialize default SwitchListViewScheme with default themezation
 # Example to create SwitchListViewScheme:
 # Code
 ```
 let scheme = SwitchListViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct SwitchListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The custom switch visal scheme
    public var customSwitchScheme: CustomSwitchScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        customSwitchScheme = CustomSwitchScheme(theme: theme)
    }
}
