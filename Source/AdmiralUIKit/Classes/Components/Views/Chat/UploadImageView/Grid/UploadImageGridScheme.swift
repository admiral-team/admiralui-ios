//
//  UploadImageGridScheme.swift
//  AdmiralUIKit
//
//  Created on 19.01.2022.
//

import AdmiralTheme
import AdmiralUIResources

/**
 UploadImageGridViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - UploadImageGridViewScheme() - Initialize default UploadImageGridViewScheme with default themezation
Example to create UploadImageGridViewScheme:
Code
 ```
let scheme = UploadImageGridViewScheme()
 ```
 */
public struct UploadImageGridViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// A color of ChatBubbleView.
    public var chatBubbleColor: AColor
    
    /// A color of Error Image.
    public var errorImageColor: AColor

    /// A child schema of UploadImageGridView.
    public var uploadImageViewScheme: UploadImageViewScheme

    /// A child schema of UploadImageGridView.
    public var chatBubbleStatusScheme: ChatBubbleStatusViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        uploadImageViewScheme = UploadImageViewScheme(theme: theme)
        chatBubbleStatusScheme = ChatBubbleStatusViewScheme(theme: theme)
        
        chatBubbleColor = theme.colors.backgroundModalView.withAlpha(alpha)
        errorImageColor = theme.colors.elementError
        uploadImageViewScheme = UploadImageViewScheme(theme: theme)
    }

}
