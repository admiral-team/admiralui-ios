//
//  PickerViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 14.07.2021.
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 PickerViewScheme - the visual scheme of UIKitPickerView.
 You can create a by specifying the following parameters in init:
 - PickerViewScheme() - Initialize default PickerViewScheme with default themezation
 # Example to create PickerViewScheme:
 # Code
 ```
 let scheme = PickerViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PickerViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color
    public var backgroundColor: AColor

    /// The title color
    public var titleColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }

}

