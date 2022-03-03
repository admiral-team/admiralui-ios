//
//  InfoAgreementViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct InfoAgreementViewScheme: AppThemeScheme {
    
    public var titleColor: AColor
    public var titleFont: AFont
    
    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.subhead4
    }
}
