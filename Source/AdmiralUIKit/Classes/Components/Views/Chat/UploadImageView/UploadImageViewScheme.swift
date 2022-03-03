//
//  UploadImageViewScheme.swift
//  AdmiralUIKit
//
//  Created on 29.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

/// The scheme of UploadImageView.
public struct UploadImageViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The chatBubble color.
    public var chatBubbleColor: AColor

    /// The scheme of ProgressViewComponent.
    public var progressViewScheme = ProgressViewScheme()

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        chatBubbleColor = theme.colors.backgroundModalView.withAlpha(alpha)

        progressViewScheme = ProgressViewScheme(theme: theme)
    }

}
