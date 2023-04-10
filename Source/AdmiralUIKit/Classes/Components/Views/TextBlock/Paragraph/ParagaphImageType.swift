//
//  ParagaphImageType.swift
//  AdmiralUIKit
//
//  Created on 18.07.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ParagaphImageType - Public enum for paragraph text block style AdmiralUIKit library
 
 ParagaphImageType can be one of the following values:
 - point
 - check
 - custom(Image) - for type with custom Image
 */
public enum ParagaphImageType {
    case point
    case check
    case custom(UIImage)
    
    var image: UIImage {
        switch self {
        case .point:
            return AdmiralUIResources.SystemAsset.Custom.Cell.point.image
        case .check:
            return AdmiralUIResources.Asset.Service.Outline.checkClearOutline.image
        case .custom(let image):
            return image
        }
    }
}
