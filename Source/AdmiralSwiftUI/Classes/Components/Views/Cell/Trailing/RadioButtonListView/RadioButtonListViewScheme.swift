//
//  RadioButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 RadioButtonListViewScheme - the visual scheme of RadioButtonListView.
 You can create a by specifying the following parameters in init:
 - RadioButtonListViewScheme() - Initialize default RadioButtonListViewScheme with default themezation
 # Example to create RadioButtonListViewScheme:
 # Code
 ```
 let scheme = RadioButtonListViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct RadioButtonListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The radio button visual scheme
    public var radioButtonScheme: CheckControlScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        radioButtonScheme = CheckControlScheme(theme: theme)
    }
}
