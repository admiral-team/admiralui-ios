//
//  OutlineSliderTabItem.swift
//  AdmiralSwiftUI
//
//  Created on 10.02.2022.
//

import Foundation

/// Item for Outline slider tab.
 public struct OutlineSliderTabItem {

     // MARK: - Public Properties

     /// Title item.
     public let title: String

     /// Badge style. Default is none.
     public let badgeStyle: BadgeStyle?
     
     /// The outline slider tab item accessibility id
     public let accessibilityId: String

     // MARK: - Initializer

     public init(title: String, badgeStyle: BadgeStyle?, accessibilityId: String = "") {
         self.title = title
         self.badgeStyle = badgeStyle
         self.accessibilityId = accessibilityId
     }

 }
