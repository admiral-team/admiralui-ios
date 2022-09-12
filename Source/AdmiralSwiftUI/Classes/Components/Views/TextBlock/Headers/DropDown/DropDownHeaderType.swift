//
//  DropDownHeaderStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.09.2021.
//

import AdmiralUIResources
import SwiftUI

/**
 DropDownHeaderType - Public enum for DropDownHeader AdmiralSwiftUI library
 
 DropDownHeaderType can be one of the following values:
 - up
 - down
 - custom(Image) - DropDownHeaderType with custom image
 */
@available(iOS 14.0, *)
public enum DropDownHeaderType {
    case up
    case down
    case custom(Image)
    
    var image: Image {
        switch self {
        case .up:
            return Image(uiImage: AdmiralUIResources.Asset.System.Outline.chevronUpOutline.image)
        case .down:
            return Image(uiImage: AdmiralUIResources.Asset.System.Outline.chevronDownOutline.image)
        case .custom(let image):
            return image
        }
    }
}
