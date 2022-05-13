//
//  InformersSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class InformersSwiftUIViewModel: ObservableObject {

    enum InformersSwiftUIItem: Int, CaseIterable {
        case bigInformers
        case smallInformers

        var title: String {
            switch self {
            case .bigInformers:
                return "Big Informers"
            case .smallInformers:
                return "Small Informers"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Informers"
    }

}
