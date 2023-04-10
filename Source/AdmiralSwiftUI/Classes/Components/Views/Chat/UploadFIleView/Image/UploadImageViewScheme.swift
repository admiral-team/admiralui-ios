//
//  UploadFileViewScheme.swift
//  AdmiralUIResources
//
//  Created on 28.10.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 UploadImageViewScheme - the visual scheme of UploadImageView.
 You can create a by specifying the following parameters in init:
 - UploadImageViewScheme() - Initialize default UploadImageViewScheme with default themezation
 # Example to create UploadImageViewScheme:
 # Code
 ```
 let scheme = UploadImageViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct UploadImageViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color
    public var textColor: AColor

    /// The text font
    public var textFont: AFont

    /// The progress color
    public var progressColor: AColor

    // MARK: - Init/deinit

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textStaticWhite
        progressColor = theme.colors.backgroundModalView
        textFont = theme.fonts.caption1
    }

}

