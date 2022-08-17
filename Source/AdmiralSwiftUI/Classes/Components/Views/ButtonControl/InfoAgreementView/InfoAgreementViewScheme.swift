//
//  InfoAgreementViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct InfoAgreementViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title color of InfoAgreementView
    public var titleColor: AColor

    /// The title font of InfoAgreementView
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.subhead4
    }
}
