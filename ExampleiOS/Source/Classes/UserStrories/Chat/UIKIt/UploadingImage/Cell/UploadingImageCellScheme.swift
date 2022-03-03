//
//  UploadingImageCellScheme.swift
//  ExampleiOS
//
//  Created on 29.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct UploadingImageCellScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor

    public init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        titleFont = theme.fonts.headline
        textColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
    }
}
