//
//  ChatButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 25.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 ChatButtonCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ChatButtonCustomScheme() - Initialize default ChatButtonCustomScheme with default themezation
Example to create ChatButtonCustomScheme:
Code
 ```
let scheme = ChatButtonCustomScheme()
 ```
 */
public struct ChatButtonCustomScheme: AppThemeScheme {

    /// Normal text color.
    public var normalTextColor: AColor

    /// Disabled text color.
    public var disabledTextColor: AColor

    /// Background layer color.
    public var backgroundLayerColor: AColor

    /// Background normal color.
    public var backgroundNormalColor: AColor

    /// Background hightlighted color.
    public var backgroundHightlightedColor: AColor

    /// Background disabled color.
    public var backgroundDisabledColor: AColor

    /// Title label font.
    public var titleLabelFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1

        normalTextColor = theme.colors.textStaticWhite
        disabledTextColor = theme.colors.textStaticWhite.withAlpha(alpha)
        
        backgroundLayerColor = theme.colors.backgroundBasic
        backgroundNormalColor = theme.colors.backgroundAccent
        backgroundHightlightedColor = theme.colors.backgroundAccentPressed
        backgroundDisabledColor = theme.colors.backgroundAccent.withAlpha(alpha)
    }

}
