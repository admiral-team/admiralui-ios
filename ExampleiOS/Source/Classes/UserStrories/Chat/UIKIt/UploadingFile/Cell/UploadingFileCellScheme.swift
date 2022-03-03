//
//  UploadingFileCellScheme.swift
//  ExampleiOS
//
//  Created on 29.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct UploadingFileCellScheme {

    var backgroundColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }
}
