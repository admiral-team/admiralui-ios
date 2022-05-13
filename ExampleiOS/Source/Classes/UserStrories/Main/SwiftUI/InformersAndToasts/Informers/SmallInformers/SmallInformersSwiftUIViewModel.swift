//
//  SmallInformersSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class SmallInformersSwiftUIViewModel: ObservableObject {

    struct SmallInformerItem: Hashable {
        let id = UUID().uuidString
        let style: InformerStyleSwiftUI
        let arrowDirection: SmallInformerArrowDirection
        let title: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(style)
            hasher.combine(arrowDirection)
        }

        static func == (lhs: SmallInformerItem, rhs: SmallInformerItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [SmallInformerItem]

    // MARK: - Internal Properties

    var title: String {
        "Small Informers"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(style: .default, arrowDirection: .top, title: "Default"),
            .init(style: .success, arrowDirection: .top, title: "Success"),
            .init(style: .attention, arrowDirection: .bottom, title: "Attention"),
            .init(style: .error, arrowDirection: .bottom, title: "Error")
        ]
    }

}
