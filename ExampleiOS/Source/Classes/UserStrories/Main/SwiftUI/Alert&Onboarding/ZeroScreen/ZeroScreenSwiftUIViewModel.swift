//
//  ZeroScreenSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class ZeroScreenSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isLoadingButton = false

    // MARK: - Internal Properties

    var navigationTitle: String {
        "ZeroScreen"
    }

    var title: String {
        "Title Center"
    }

    var subTitle: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    var buttonTitle: String {
        "Хорошо"
    }

}
