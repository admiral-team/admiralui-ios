//
//  ToolbarItem.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit

public enum ToolbarItemType: String {
    case `default`
    case error
    case success
    case attention
}

public struct ToolbarItem {
    
    public let title: String
    public let image: UIImage
    public let type: ToolbarItemType?
    public let titleColor: UIColor?
    public let imageTintColor: UIColor?
    public let accesibilityId: String?
    
    public init(
        title: String,
        image: UIImage,
        type: ToolbarItemType = .default,
        accesibilityId: String? = nil
    ) {
        self.title = title
        self.image = image
        self.type = type
        self.titleColor = nil
        self.imageTintColor = nil
        self.accesibilityId = accesibilityId
    }
    
    public init(
        title: String,
        image: UIImage,
        titleColor: UIColor?,
        imageTintColor: UIColor?,
        accesibilityId: String? = nil
    ) {
        self.title = title
        self.image = image
        self.type = nil
        self.titleColor = titleColor
        self.imageTintColor = imageTintColor
        self.accesibilityId = accesibilityId
    }
    
}
