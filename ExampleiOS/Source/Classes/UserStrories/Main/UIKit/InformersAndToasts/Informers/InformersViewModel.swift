//
//  InformersViewModel.swift
//  ExampleiOS
//
//  Created on 13.05.2022.
//

import Foundation

import Foundation

final class InformersViewModel {

    enum Items: CaseIterable {
        case big
        case small

        func getTitle() -> String {
            switch self {
            case .big:
                return "Big Informers"
            case .small:
                return "Small Informers"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
