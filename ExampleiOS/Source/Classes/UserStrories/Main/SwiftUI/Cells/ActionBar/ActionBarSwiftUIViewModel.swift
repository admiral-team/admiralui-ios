//
//  ActionBarSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class ActionBarSwiftUIViewModel: ObservableObject {

    enum ActionBarSwiftUIItem: String, CaseIterable {
        case `default`
        case secondary

        var title: String {
            switch self {
            case .default:
                return "ActionBar - Type default"
            case .secondary:
                return "ActionBar - Type secondary"
            }
        }

    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "ActionBar"
    }

}
