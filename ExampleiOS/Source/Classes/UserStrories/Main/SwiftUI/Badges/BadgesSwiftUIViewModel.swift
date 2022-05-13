//
//  BadgesSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 25.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class BadgesSwiftUIViewModel: ObservableObject {

    enum BadgesItem: CaseIterable {
        case normal
        case small

        var title: String {
            switch self {
            case .normal:
                return "Normal"
            case .small:
                return "Small"
            }
        }
    }

    // MARK: - Internal Properties

    var title: String {
        "Badges"
    }

}
