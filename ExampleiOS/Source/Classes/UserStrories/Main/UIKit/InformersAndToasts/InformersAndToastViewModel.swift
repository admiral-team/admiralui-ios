//
//  InformersAndToastViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import Foundation

final class InformersAndToastViewModel {

    enum Items: CaseIterable {
        case informers
        case notifications

        func getTitle() -> String {
            switch self {
            case .informers:
                return "Informers"
            case .notifications:
                return "Notifications"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
