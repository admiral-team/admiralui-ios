//
//  BaseCellSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class BaseCellSwiftUIViewModel: ObservableObject {

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

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Base Cells"
    }

}
