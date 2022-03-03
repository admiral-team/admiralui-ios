//
//  MapButtonsViewModel.swift
//  ExampleiOS
//
//  Created on 18.02.2022.
//

import Foundation

final class MapButtonsViewModel {

    enum Items: CaseIterable {
        case list

        func getTitle() -> String {
            switch self {
            case .list:
                return "List"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
