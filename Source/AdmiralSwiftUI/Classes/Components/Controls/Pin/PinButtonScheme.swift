//
//  PinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinButtonScheme - the visual scheme of PinButtonStyle.
 You can create a by specifying the following parameters in init:
 - PinButtonScheme() - Initialize default PinButtonScheme with default themezation
 - PinButtonScheme(
     backgroundColor: AColor - the background color of PinButtonStyle,
     selectedbackgroundColor: AColor - the selected background color of PinButtonStyle,
     shadowColor: AColor -  the shadow color of PinButtonStyle,
   )

Example to create PinButtonScheme:
Code
 ```
let scheme = PinButtonScheme()
let customScheme = PinButtonScheme(
    backgroundColor: AppTheme.default.colors.specialExtra22,
    selectedbackgroundColor: AppTheme.default.colors.specialExtra22,
    shadowColor: AColor(hexString: "#FFFFFF")
)
 ```
 */
@available(iOS 14.0.0, *)
public struct PinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The selected backgroundColor of PinButton
    public var selectedBackgroundColor: AColor

    /// The background color of PinButton
    public var backgroundColor: AColor

    /// The shadow color of PinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(
        backgroundColor: AColor,
        selectedBackgroundColor: AColor,
        shadowColor: AColor
    ) {
        self.backgroundColor = backgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.shadowColor = shadowColor
    }

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundAccent
        selectedBackgroundColor = theme.colors.backgroundAccent.withAlpha(alpha)
        shadowColor = theme.colors.backgroundShadow
    }
    
}
