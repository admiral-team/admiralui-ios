//
//  ToolBarStyle.swift
//  AdmiralUIResources
//
//  Created on 31.05.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 ToolBarScheme - the visual scheme of MapButtonStyle.
 You can create a by specifying the following parameters in init:
 - ToolBarScheme() - Initialize default ToolBarScheme with default themezation
 - ToolBarScheme(
     backgroundColorNormal: AColor - the border color of MapButtonStyle,
     backgroundColorHighlighted: AColor - the background color of MapButtonStyle,,
     imageTintColor: AColor - the image tint color of MapButtonStyle,
     shadowColor: AColor - the shadow color of MapButtonStyle
 )

 Example to create ToolBarScheme:
 Code
 ```
 let scheme = ToolBarScheme()
 let customScheme = ToolBarScheme(
 backgroundColor: AppTheme.default.colors.specialExtra22,
 shadowColor: AColor(hexString: "#FFFFFF")
 )
 ```
 */
@available(iOS 14.0.0, *)
public struct ToolBarScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The background color of ToolBar
    public var backgroundColor: AColor

    /// The shadow color of ToolBar
    public var shadowColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        self.init(
            backgroundColor: theme.colors.backgroundAccentDark,
            shadowColor: theme.colors.backgroundShadow
        )
    }

    public init(
        backgroundColor: AColor,
        shadowColor: AColor
    ) {
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
    }

}

