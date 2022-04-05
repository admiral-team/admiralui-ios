//
//  BagesViewModel.swift
//  ExampleiOS
//
//  Created on 05.04.2022.
//

import Foundation

final class BadgesViewModel {

    enum Items: CaseIterable {
        case normal
        case small

        func getTitle() -> String {
            switch self {
            case .normal:
                return "Normal"
            case .small:
                return "Small"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
