//
//  ImageBaseCellSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum ImageBaseCellSwiftUIItem: Int, CaseIterable {
    case lable
    case leading
    case trailing
    
    var title: String {
        switch self {
        case .lable:
            return "Leading Elements"
        case .leading:
            return "Center Elements"
        case .trailing:
            return "Trailing Elements"
        }
    }
}
