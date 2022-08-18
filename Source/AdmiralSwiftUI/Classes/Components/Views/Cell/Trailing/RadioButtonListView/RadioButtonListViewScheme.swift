//
//  RadioButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct RadioButtonListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of RadioButtonListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The radio button color of RadioButtonListView
    public var radioButtonView: CheckControlScheme

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        radioButtonView = CheckControlScheme(theme: theme)
    }
}
