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
    case baseImageCell
    case textCell
    case titleCell
    case actionbar
    
    var title: String {
        switch self {
        case .baseCell:
            return "Base Cells"
        case .baseImageCell:
            return "Base Cells vs Image"
        case .textCell:
            return "Text Cells"
        case .titleCell:
            return "Title Cells"
        case .actionbar:
            return "Actionbar"
        }
    }
}
