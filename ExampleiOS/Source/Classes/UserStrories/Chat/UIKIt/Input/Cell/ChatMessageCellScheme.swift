//
//  ChatMessageCellScheme.swift
//  ExampleiOS
//
//  Created on 02.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct ChatMessageCellScheme {

    var titleFont: AFont
    var textColor: AColor
    var backgroundColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        titleFont = theme.fonts.body1
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
}
