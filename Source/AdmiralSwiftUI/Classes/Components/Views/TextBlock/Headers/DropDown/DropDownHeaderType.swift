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
    /// The up type of DropDown
    case up
    /// The down type of DropDown
    case down
    /// The custom type of DropDown
    case custom(Image)

    // MARK: - Computed Properties

    var image: Image {
        switch self {
        case .up:
            return Image(uiImage: AdmiralUIResources.PrivateAsset.Custom.Cell.arrowUp.image)
        case .down:
            return Image(uiImage: AdmiralUIResources.PrivateAsset.Custom.Cell.arrowDown.image)
        case .custom(let image):
            return image
        }
    }
}
