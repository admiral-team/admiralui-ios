//
//  TextBlocksSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum TextBlocksSwiftUIItem: Int, CaseIterable {
    case header
    case dropDown
    case paragraph
    case link
    case separator
    
    var title: String {
        switch self {
        case .header:
            return "Header"
        case .dropDown:
            return "Accordion"
        case .paragraph:
            return "Paragraph"
        case .link:
            return "Link"
        case .separator:
            return "Padding"
        }
    }
}
