//
//  BaseCellSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum BaseCellSwiftUIItem: Int, CaseIterable {
    case leading
    case traling
    
    var title: String {
        switch self {
        case .leading:
            return "Leading Elements"
        case .traling:
            return "Trailing Elements"
        }
    }
}
