//
//  BigInformersSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class BigInformersSwiftUIViewModel: ObservableObject {

    struct BigInformerItem: Hashable {
        let id = UUID().uuidString
        let style: InformerStyleSwiftUI
        let title: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(style)
        }

        static func == (lhs: BigInformerItem, rhs: BigInformerItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [BigInformerItem]

    // MARK: - Internal Properties

    var title: String {
        "Big Informers"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(style: .default, title: "Default"),
            .init(style: .success, title: "Success"),
            .init(style: .attention, title: "Attention"),
            .init(style: .error, title: "Error")
        ]
    }

}
