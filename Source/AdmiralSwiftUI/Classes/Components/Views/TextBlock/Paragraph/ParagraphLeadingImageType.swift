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
    case point
    case check
    case custom(Image)
    
    var image: Image {
        switch self {
        case .point:
            return Image(uiImage: AdmiralUIResources.SystemAsset.Custom.Cell.point.image)
        case .check:
            return AdmiralUIResources.AssetSymbol.Service.Outline.checkClear.image
        case .custom(let image):
            return image
        }
    }
}
