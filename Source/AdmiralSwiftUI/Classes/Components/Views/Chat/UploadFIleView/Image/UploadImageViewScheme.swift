//
//  UploadFileViewScheme.swift
//  AdmiralUIResources
//
//  Created on 28.10.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct UploadImageViewScheme: AppThemeScheme {

    // MARK: - Properties

    public var textColor: AColor
    public var textFont: AFont
    public var loadingMaskColor: AColor

    // MARK: - Init/deinit

    public init(theme: AppTheme) {
        textColor = theme.colors.textStaticWhite
        loadingMaskColor = theme.colors.backgroundModalView
        textFont = theme.fonts.caption1
    }

}
