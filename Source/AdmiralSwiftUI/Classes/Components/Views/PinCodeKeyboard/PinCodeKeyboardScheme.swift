//
//  PinCodeKeyboardScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 PinCodeKeyboardScheme - the visual scheme of PinCodeKeyboardView.
 You can create a by specifying the following parameters in init:
 - PinCodeKeyboardScheme() - Initialize default PinCodeKeyboardScheme with default themezation
 - PinCodeKeyboardScheme(
 backgroundColor: AColor
 )
 # Example to create PinCodeKeyboardScheme:
 # Code
 ```
 let scheme = PinCodeKeyboardScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PinCodeKeyboardScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PinCodeKeyboard
    public var backgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
    }

    public init(backgroundColor: AColor) {
        self.backgroundColor = backgroundColor
    }

}

