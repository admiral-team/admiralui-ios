//
//  SeveralPinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.08.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 SeveralPinButtonScheme - the visual scheme of SeveralPinButtonStyle.
 You can create a by specifying the following parameters in init:
 - SeveralPinButtonScheme() - Initialize default PinButtonScheme with default themezation
 - SeveralPinButtonScheme(
     borderColor: AColor - the border color of SeveralPinButtonStyle,
     backgroundColor: AColor - the background color of SeveralPinButtonStyle,
     textColor: AColor - the text color of SeveralPinButtonStyle,
     shadowColor: AColor -  the shadow color of SeveralPinButtonStyle
   )
Example to create SeveralPinButtonScheme:
Code
 ```
 let scheme = SeveralPinButtonScheme()
 let customScheme = SeveralPinButtonScheme(
 borderColor: AppTheme.default.colors.specialExtra22,
 backgroundColor: AppTheme.default.colors.specialExtra22,
 textColor: AColor(hexString: "#FFFFFF"),
 shadowColor: AColor(hexString: "#FFFFFF")
 )
 ```
 */
@available(iOS 14.0.0, *)
public struct SeveralPinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The border color of SeveralPinButton
    public var borderColor: AColor

    /// The background color of SeveralPinButton
    public var backgroundColor: AColor

    /// The text color of SeveralPinButton
    public var textColor: AColor

    /// The shadow color of SeveralPinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        self.init(
            borderColor: theme.colors.backgroundAccent,
            backgroundColor: theme.colors.backgroundBasic,
            textColor: theme.colors.textPrimary,
            shadowColor: theme.colors.backgroundShadow
        )
    }

    public init(
        borderColor: AColor,
        backgroundColor: AColor,
        textColor: AColor,
        shadowColor: AColor
    ) {
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.shadowColor = shadowColor
    }

}
