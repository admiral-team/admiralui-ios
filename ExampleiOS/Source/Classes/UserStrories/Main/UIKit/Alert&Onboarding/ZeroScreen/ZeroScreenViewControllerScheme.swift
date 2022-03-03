//
//  ZeroScreenViewControllerScheme.swift
//  ExampleiOS
//
//  Created on 17.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import AdmiralUIKit

struct ZeroScreenControllerScheme {

    var backgroundColor: AColor

    var zeroScreenViewScheme: ZeroScreenScheme

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        zeroScreenViewScheme = ZeroScreenScheme(theme: theme)
    }
}
