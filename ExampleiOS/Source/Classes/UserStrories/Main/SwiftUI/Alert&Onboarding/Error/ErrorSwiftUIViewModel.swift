//
//  ErrorSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class ErrorSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isLoading = false

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Error View"
    }
    
    var buttonTitle: String {
        "Хорошо"
    }

    var text: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

}
