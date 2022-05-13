//
//  InformersAndToastSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class InformersAndToastSwiftUIViewModel: ObservableObject {

    enum InformersAndToastsSwiftUItem: Int, CaseIterable {
        case informers
        case notifications

        var title: String {
            switch self {
            case .informers:
                return "Informers"
            case .notifications:
                return "Notifications"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Informers & Notifications"
    }

}
