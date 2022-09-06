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
 ```
 */
@available(iOS 14.0.0, *)
public struct ToolBarScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The background color of ToolBar
    public var backgroundColor: AColor

    /// The shadow color of ToolBar
    public var shadowColor: AColor

    /// The item scheme
    public var itemScheme: ToolBarItemScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        self.backgroundColor = theme.colors.backgroundAccentDark
        self.shadowColor = theme.colors.backgroundShadow
        self.itemScheme = ToolBarItemScheme(theme: theme)
    }

}

