//
//  TextInputDecorationViewScheme.swift
//  AdmiralUIKit
//
//  Created on 19.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TextInputDecorationViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TextInputDecorationViewScheme() - Initialize default TextInputDecorationViewScheme with default themezation
Example to create TextInputDecorationViewScheme:
Code
 ```
let scheme = TextInputDecorationViewScheme()
 ```
 */
public struct TextInputDecorationViewScheme: AppThemeScheme {

    /// Name label font.
    public var nameFont: AFont

    /// Name label enable font.
    public var nameEnableFont: AFont

    /// Placeholder font.
    public var placeholderFont: AFont

    /// Informer font.
    public var informerFont: AFont

    /// Name label min font.
    public var nameLabelMinFont: AFont
    
    /// Leading label font.
    public var leadingTextFont: AFont
    
    public init(theme: AppTheme = .default) {
        nameFont = theme.fonts.subhead3
        nameEnableFont = theme.fonts.body1
        placeholderFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
        nameLabelMinFont = theme.fonts.subhead3
        leadingTextFont = theme.fonts.body1
    }
    
}
