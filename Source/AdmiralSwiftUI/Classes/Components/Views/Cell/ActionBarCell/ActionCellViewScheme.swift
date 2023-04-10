//
//  ActionCellViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ActionCellViewScheme - the visual scheme of ActionCellView.
 You can create a by specifying the following parameters in init:
 - ActionCellViewScheme() - Initialize default ActionCellViewScheme with default themezation
 # Example to create ActionCellViewScheme:
 # Code
 ```
 let scheme = ActionCellViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ActionCellViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The parameter that sets background color with state
    public var actionBarBackgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        actionBarBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
