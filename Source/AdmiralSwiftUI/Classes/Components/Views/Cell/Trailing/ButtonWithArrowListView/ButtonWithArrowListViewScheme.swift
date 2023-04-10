//
//  ButtonWithArrowListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ButtonWithArrowListViewScheme - the visual scheme of ButtonListView.
 You can create a by specifying the following parameters in init:
 - ButtonWithArrowListViewScheme() - Initialize default ButtonWithArrowListViewScheme with default themezation
 # Example to create ButtonWithArrowListViewScheme:
 # Code
 ```
 let scheme = ButtonWithArrowListViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ButtonWithArrowListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()
    public var button: GhostButtonWithImageScheme
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        button = GhostButtonWithImageScheme(theme: theme)
    }
}
