//
//  TagsChipsViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class TagsChipsViewModel: ObservableObject {

    enum TagChipiItem: String, CaseIterable {
        case `default` = "Default"
        case additional = "Additional"
        case success = "Success"
        case erro = "Error"
        case attention = "Attention"
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Tags & Chips"
    }

    var tabItems: [String] {
        ["Default", "Disabled"]
    }

}
