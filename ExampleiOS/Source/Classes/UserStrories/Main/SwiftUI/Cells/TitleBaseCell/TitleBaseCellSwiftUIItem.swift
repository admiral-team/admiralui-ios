//
//  TitleBaseCellSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 23.06.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum TitleBaseCellSwiftUIItem: Int, CaseIterable {
    case primary
    case secondary
    
    var title: String {
        switch self {
        case .primary:
            return "Primary"
        case .secondary:
            return "Secondary"
        }
    }
}
