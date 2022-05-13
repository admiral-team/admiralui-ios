//
//  SecondaryTitleBaseCellSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class SecondaryTitleBaseCellSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Secondary"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

}
