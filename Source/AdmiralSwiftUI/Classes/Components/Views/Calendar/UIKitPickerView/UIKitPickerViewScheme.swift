//
//  PickerViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 14.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PickerViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PickerView
    public var backgroundColor: AColor

    /// The title color of PickerView
    public var titleColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
    
}

