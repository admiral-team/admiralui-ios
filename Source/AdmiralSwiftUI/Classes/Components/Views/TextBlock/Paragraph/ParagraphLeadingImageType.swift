//
//  ParagraphImageType.swift
//  AdmiralSwiftUI
//
//  Created on 27.09.2021.
//

import AdmiralUIResources
import SwiftUI
/**
 ParagraphLeadingImageType - Public enum for paragraph text block style AdmiralSwiftUI library
 ParagraphLeadingImageType can be one of the following values:
 - point
 - check
 - custom(Image) - for type with custom Image
 */
@available(iOS 14.0, *)
public enum ParagraphLeadingImageType {
    /// Set point image in imageview
    case point
    /// Set check image in imageview
    case check
    /// Set custom image in imageview
    case custom(Image)

    // MARK: - Computed Properties

    public var image: Image {
        switch self {
        case .point:
            return Image(uiImage: ImageAssets.Custom.Cell.point.image)
        case .check:
            return SymbolAssets.Service.Outline.checkClear.swiftUIImage
        case .custom(let image):
            return image
        }
    }
}

