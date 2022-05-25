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
    case center
    case traling
    
    var title: String {
        switch self {
        case .center:
            return "Center Elements"
        case .leading:
            return "Leading Elements"
        case .traling:
            return "Trailing Elements"
        }
    }
}
