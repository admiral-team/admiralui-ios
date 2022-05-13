//
//  PageControlsViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import Foundation

final class PageControlsViewModel {

    enum Items: CaseIterable {
        case linear
        case circle

        func getTitle() -> String {
            switch self {
            case .linear:
                return "Liner"
            case .circle:
                return "Circle"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
