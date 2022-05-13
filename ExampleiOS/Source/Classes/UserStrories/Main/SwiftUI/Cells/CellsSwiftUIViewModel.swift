//
//  CellsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class CellsSwiftUIViewModel: ObservableObject {

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

    // MARK: - Published Properties

    @Published var selection: Int? 

    // MARK: - Internal Properties

    var title: String {
        "Cells"
    }

}
