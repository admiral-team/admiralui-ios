//
//  CellsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum CellsSwiftUIItem: Int, CaseIterable {
    case baseCell
    case actionbar
    
    var title: String {
        switch self {
        case .baseCell:
            return "Base Cells"
        case .actionbar:
            return "Actionbar"
        }
    }
}
