//
//  CheckBoxListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CheckBoxListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of CheckBoxListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The checkboxview scheme
    public var checkBoxView: CheckControlScheme

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        checkBoxView = CheckControlScheme(theme: theme)
    }
}
