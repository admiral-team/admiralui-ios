//
//  UploadImageViewScheme.swift
//  AdmiralUIKit
//
//  Created on 29.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 UploadImageViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - UploadImageViewScheme() - Initialize default UploadImageViewScheme with default themezation
Example to create UploadImageViewScheme:
Code
 ```
let scheme = UploadImageViewScheme()
 ```
 */
public struct UploadImageViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The chatBubble color.
    public var chatBubbleColor: AColor

    /// The scheme of ProgressViewComponent.
    public var progressViewScheme = ProgressViewScheme()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        chatBubbleColor = theme.colors.backgroundModalView.withAlpha(alpha)

        progressViewScheme = ProgressViewScheme(theme: theme)
    }

}
