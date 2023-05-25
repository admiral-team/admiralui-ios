//
//  TextMessageListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme

/**
 TextMessageListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TextMessageListViewScheme() - Initialize default TextMessageListViewScheme with default themezation
Example to create TextMessageListViewScheme:
Code
 ```
let scheme = TextMessageListViewScheme()
 ```
 */
public struct TextMessageListViewScheme: AppThemeScheme {

    /// Message title label title color.
    public var messageTitleLabelTitleColor = ControlParameter<AColor>()

    /// Message view background color.
    public var messageViewBackgroundColor = ControlParameter<AColor>()

    /// View background color.
    public var viewBackgroundColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        viewBackgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        viewBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        messageTitleLabelTitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        messageTitleLabelTitleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        messageViewBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        titleFont = theme.fonts.subhead4
    }
}
