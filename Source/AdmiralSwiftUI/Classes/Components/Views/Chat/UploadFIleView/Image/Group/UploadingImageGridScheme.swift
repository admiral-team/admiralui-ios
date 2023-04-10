//
//  UploadingImageGridScheme.swift
//  AdmiralSwiftUI
//
//  Created on 29.08.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct UploadingImageGridScheme: AppThemeScheme {
    
    // MARK: - Public properties
    
    /// The error image color.
    public var errorImageColor: AColor

    /// Upload image scheme.
    public var uploadImageScheme: UploadImageViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme) {
        errorImageColor = theme.colors.elementError
        uploadImageScheme = UploadImageViewScheme(theme: theme)
    }
}
