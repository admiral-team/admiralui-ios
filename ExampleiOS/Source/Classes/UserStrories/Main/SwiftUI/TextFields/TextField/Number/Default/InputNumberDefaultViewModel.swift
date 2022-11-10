//
//  InputNumberDefaultViewModel.swift
//  ExampleiOS
//
//  Created by on 08.11.2022.
//  
//

import Combine
import Foundation

@available(iOS 13.0, *)
final class InputNumberDefaultViewModel: ObservableObject {

    struct InputNumberDefaultItem: Identifiable {
        let id = UUID().uuidString
        let title: String
        let maximumValue: Double
        let minimunValue: Double
        var currentValue: Double
    }

    // MARK: - Internal Properties

    @Published var items: [InputNumberDefaultItem]

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "5 Symbols", maximumValue: 10000, minimunValue: 0, currentValue: 1),
            .init(title: "6 Symbols", maximumValue: 100000, minimunValue: 0, currentValue: 100000),
            .init(title: "8 Symbols", maximumValue: 10000000, minimunValue: 0, currentValue: 10000000),
            .init(title: "9 Symbols", maximumValue: 100000000, minimunValue: 0, currentValue: 100000000),
            .init(title: "Unlimited", maximumValue: .infinity, minimunValue: 0, currentValue: 1)
        ]
    }

}
