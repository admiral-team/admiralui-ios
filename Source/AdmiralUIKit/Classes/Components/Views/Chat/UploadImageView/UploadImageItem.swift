//
//  UploadImageModel.swift
//  AdmiralUIKit
//
//  Created on 18.01.2022.
//

import Foundation
import UIKit

/// An initial model, that controls setting of UploadImageView.
public struct UploadImageItem {

    // MARK: - Public properties

    /// An image of UploadImageView
    public var image: UIImage?

    /// The style of UploadImageView.
    public var style: UploadImageViewStyle

    /// The state of UploadImageView.
    public var state: UploadImageViewState?

    // MARK: - Initializer

    public init(
        image: UIImage? = nil,
        style: UploadImageViewStyle = .default,
        state: UploadImageViewState? = .default
    ) {
        self.image = image
        self.style = style
        self.state = state
    }

}
