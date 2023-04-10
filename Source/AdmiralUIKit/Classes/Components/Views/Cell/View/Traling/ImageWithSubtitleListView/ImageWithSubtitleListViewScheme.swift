//
//  ImageWithSubtitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ImageWithSubtitleListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ImageWithSubtitleListViewScheme() - Initialize default ImageWithSubtitleListViewScheme with default themezation
Example to create ImageWithSubtitleListViewScheme:
Code
 ```
let scheme = ImageWithSubtitleListViewScheme()
 ```
 */
public struct ImageWithSubtitleListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image tint color.
    public var imageTintColor = ControlParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// Subtitle font.
    public var subtitleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        subtitleFont = theme.fonts.subhead3
    }
}
