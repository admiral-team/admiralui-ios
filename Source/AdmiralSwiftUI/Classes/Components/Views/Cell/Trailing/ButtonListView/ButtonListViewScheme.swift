//
//  ButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ButtonListViewScheme - the visual scheme of ButtonListView.
 You can create a by specifying the following parameters in init:
 - ButtonListViewScheme() - Initialize default ButtonListViewScheme with default themezation
 # Example to create ButtonListViewScheme:
 # Code
 ```
 let scheme = ButtonListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct ButtonListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The button visual scheme
    public var buttonScheme: GhostButtonScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        buttonScheme = GhostButtonScheme(theme: theme)
    }
}
