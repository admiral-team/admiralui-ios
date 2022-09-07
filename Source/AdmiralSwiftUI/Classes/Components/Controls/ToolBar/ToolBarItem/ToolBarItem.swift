//
//  ToolBarItem.swift
//  AdmiralSwiftUI
//
//  Created on 01.06.2021.
//

import SwiftUI

public enum ToolBarBadgeStyle {
    /// The empty style
    case empty
    /// The style witn initial value
    case value(Int)
}

public enum ToolbarItemType: String {
    /// The default type
    case `default`
    /// The error type
    case error
    /// The success type
    case success
    /// The attention type
    case attention
}
/**
 ToolBarItem - A model that represents an item which can be placed in the toolbar.

 You can create a ToolBarItem by specifying the following parameters in the initializer
 ## Initializer parameters:
 - name - text for ToolBarItem
 - image - image for ToolBarItem
 - badgeStyle - сan be either empty or value (Int)
 - type - this parameter is responsible for the display style: `default`, error, success, attention
 - isEnabled - this parameter is responsible for enable or disable ToolBarItem
 ## Example to create ToolBarItem:
 # Code
 ```
 ToolBarItem(
            title: "Pay",
            image: Image("Your image"),
            badgeStyle: .value(3))
 ```
*/
@available(iOS 14.0.0, *)
public struct ToolBarItem: Hashable, Identifiable {

    // MARK: - Public Properties

    public let id = UUID()

    /// The title
    public let title: String

    /// The image
    public let image: Image

    /// The badge style
    public var badgeStyle: ToolBarBadgeStyle? = nil

    /// The type
    public var type: ToolbarItemType = .default

    /// The enabled flag 
    public var isEnabled: Bool = true

    // MARK: - Initializer

    public init(
        title: String,
        image: Image,
        badgeStyle: ToolBarBadgeStyle? = nil,
        type: ToolbarItemType = .default,
        isEnabled: Bool = true
    ) {
        self.title = title
        self.image = image
        self.badgeStyle = badgeStyle
        self.type = type
        self.isEnabled = isEnabled
    }

    // MARK: - Public Methods

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    public static func == (lhs: ToolBarItem, rhs: ToolBarItem) -> Bool {
        lhs.id == rhs.id
    }

}
