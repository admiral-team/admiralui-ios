//
//  SpinnerSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class SpinnerSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Spinner"
    }

    var tabItems: [String] {
        ["Small", "Medium", "Big"]
    }

}
