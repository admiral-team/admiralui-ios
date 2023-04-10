//
//  TitleButtonDropDownScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 TitleButtonDropDownScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleButtonDropDownScheme() - Initialize default TitleButtonDropDownScheme with default themezation
Example to create TitleButtonDropDownScheme:
Code
 ```
let scheme = TitleButtonDropDownScheme()
 ```
 */
public struct TitleButtonDropDownScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Title font.
    public var titleFont: AFont

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    /// Ghost button scheme.
    public var ghostButtonScheme: HeaderButtonWithArrowScheme
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        titleFont = theme.fonts.headline
        ghostButtonScheme = HeaderButtonWithArrowScheme(theme: theme)
    }
}

