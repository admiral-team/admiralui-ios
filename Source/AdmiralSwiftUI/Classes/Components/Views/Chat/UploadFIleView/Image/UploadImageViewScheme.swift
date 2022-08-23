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

    /// The text color of UploadImageView
    public var textColor: AColor

    /// The text font of UploadImageView
    public var textFont: AFont

    /// The loading mask color of UploadImageView
    public var loadingMaskColor: AColor

    // MARK: - Init/deinit

    public init(theme: AppTheme) {
        textColor = theme.colors.textStaticWhite
        loadingMaskColor = theme.colors.backgroundModalView
        textFont = theme.fonts.caption1
    }

}
