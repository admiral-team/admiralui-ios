//
//  DropDownHeaderType.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import UIKit

/**
 DropDownHeaderType - Public enum for DropDownHeader AdmiralSwiftUI library
 
 DropDownHeaderType can be one of the following values:
 - up
 - down
 - custom(Image) - DropDownHeaderType with custom image
 */
public enum DropDownHeaderType {
    case up
    case down
    case custom(UIImage)
    
    var image: UIImage {
        switch self {
        case .up:
            return Asset.System.Outline.chevronUpOutline.image
        case .down:
            return Asset.System.Outline.chevronDownOutline.image
        case .custom(let image):
            return image
        }
    }
}

