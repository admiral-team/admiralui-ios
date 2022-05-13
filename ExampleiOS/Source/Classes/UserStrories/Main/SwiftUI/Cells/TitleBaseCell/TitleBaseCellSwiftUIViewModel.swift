//
//  TitleBaseCellSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class TitleBaseCellSwiftUIViewModel: ObservableObject {

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

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Title Cells"
    }

}
