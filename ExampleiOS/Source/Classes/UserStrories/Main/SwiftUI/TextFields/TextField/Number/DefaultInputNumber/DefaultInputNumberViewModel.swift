//
//  DefaultInputNumberViewModel.swift
//  ExampleiOS
//
//  Created by on 13.10.2022.
//  
//

import Foundation

@available(iOS 13.0, *)
final class DefaultInputNumberViewModel: ObservableObject {

    struct InputNumberItem {
        let title: String
        var maximumValue: Double
        var value: Double
    }

    // MARK: - Published Properties

    @Published var items: [InputNumberItem]
    @Published var isEnabledControlsState = 0

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "5 symbols", maximumValue: 10000, value: 1),
            .init(title: "6 symbols", maximumValue: 100000, value: 100000),
            .init(title: "8 symbols", maximumValue: 10000000, value: 10000000),
            .init(title: "10 symbols", maximumValue: 100000000, value: 100000000),
            .init(title: "Unlimited", maximumValue: 10000000000, value: 1)
        ]
    }

    // MARK: - Computed Properties

    var navigationTitle: String {
        "Default"
    }

}
