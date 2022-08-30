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
     public var badgeStyle: BadgeStyle?

     // MARK: - Initializer
     public init(title: String, badgeStyle: BadgeStyle?) {
         self.title = title
         self.badgeStyle = badgeStyle
     }

 }
