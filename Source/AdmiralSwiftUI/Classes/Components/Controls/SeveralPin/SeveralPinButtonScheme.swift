//
//  SeveralPinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.08.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 SeveralPinButtonScheme - the visual scheme Style.
 You can create a by specifying the following parameters in init:
 - SeveralPinButtonScheme() - Initialize default PinButtonScheme with default themezation
Example to create SeveralPinButtonScheme:
Code
 ```
 let scheme = SeveralPinButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct SeveralPinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The border color
    public var borderColor: AColor

    /// The background color
    public var backgroundColor: AColor

    /// The text color
    public var textColor: AColor

    /// The shadow color 
    public let shadowColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        borderColor = theme.colors.backgroundAccent
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textPrimary
        shadowColor = theme.colors.backgroundShadow
    }

}
