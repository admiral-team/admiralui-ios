//
//  ActionBarsViewModel.swift
//  ExampleiOS
//
//  Created on 07.02.2022.
//

import Foundation

final class ActionBarsViewModel {

    enum Items: CaseIterable {
        case `default`
        case secondary

        func getTitle() -> String {
            switch self {
            case .default:
                return "ActionBar - Type default"
            case .secondary:
                return "ActionBar - Type secondary"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
