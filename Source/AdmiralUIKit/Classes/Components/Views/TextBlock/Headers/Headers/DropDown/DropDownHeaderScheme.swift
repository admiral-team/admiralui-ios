//
//  DropDownHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import UIKit

/**
 DropDownHeaderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DropDownHeaderScheme() - Initialize default DropDownHeaderScheme with default themezation
Example to create DropDownHeaderScheme:
Code
 ```
let scheme = DropDownHeaderScheme()
 ```
 */
public struct DropDownHeaderScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Default title font.
    public var defaultTitleFont: AFont

    /// Title font.
    public var titleFont = TitleHeaderViewParameters<AFont>()

    /// Text color.
    public var textColor = TitleHeaderViewParameters<AColor>()

    /// Image tint color.
    public var imageTintColor: AColor
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: nil)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        imageTintColor = theme.colors.elementPrimary
        
        defaultTitleFont = theme.fonts.body1
    }
}
