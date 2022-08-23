//
//  MapButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 MapButtonScheme - the visual scheme of MapButtonStyle.
 You can create a by specifying the following parameters in init:
 - MapButtonScheme() - Initialize default MapButtonScheme with default themezation
 - MapButtonScheme(
     backgroundColorNormal: AColor - the border color of MapButtonStyle,
     backgroundColorHighlighted: AColor - the background color of MapButtonStyle,,
     imageTintColor: AColor - the image tint color of MapButtonStyle,
     shadowColor: AColor - the shadow color of MapButtonStyle
 )

 Example to create MapButtonScheme:
 Code
 ```
 let scheme = MapButtonScheme()
 let customScheme = MapButtonScheme(
 backgroundColorNormal: AppTheme.default.colors.specialExtra22,
 backgroundColorHighlighted: AppTheme.default.colors.specialExtra22,
 imageTintColor: AColor(hexString: "#FFFFFF"),
 shadowColor: AColor(hexString: "#FFFFFF")
 )
 ```
 */
@available(iOS 14.0.0, *)
public struct MapButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of SeveralPinButton
    public var backgroundColor = ControlParameter<AColor>()

    /// The image color of SeveralPinButton
    public let imageTintColor: AColor

    /// The shadow color of SeveralPinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(
        backgroundColorNormal: AColor,
        backgroundColorHighlighted: AColor,
        imageTintColor: AColor,
        shadowColor: AColor
    ) {
        backgroundColor.set(parameter: backgroundColorNormal, for: .normal)
        backgroundColor.set(parameter: backgroundColorHighlighted, for: .highlighted)
        self.imageTintColor = imageTintColor
        self.shadowColor = shadowColor
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundExtraSurface, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .highlighted)
        imageTintColor = theme.colors.elementPrimary
        shadowColor = theme.colors.backgroundShadow
    }

}
