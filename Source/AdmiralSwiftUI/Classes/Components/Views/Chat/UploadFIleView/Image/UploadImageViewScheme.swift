//
//  UploadFileViewScheme.swift
//  AdmiralUIResources
//
//  Created on 28.10.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
  UploadImageViewScheme - the visual scheme of UploadImageView.
   You can create a by specifying the following parameters in init:
   - UploadImageViewScheme() - Initialize default UploadImageViewScheme with default themezation
   - UploadImageViewScheme(
     textColor: AColor,
     textFont: AFont,
     loadingMaskColor: AColor
     )
   # Example to create UploadImageViewScheme:
   # Code
   ```
  let scheme = UploadImageViewScheme()
   ```
*/
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

    public init(
        textColor: AColor,
        textFont: AFont,
        loadingMaskColor: AColor
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.loadingMaskColor = loadingMaskColor
    }

}

