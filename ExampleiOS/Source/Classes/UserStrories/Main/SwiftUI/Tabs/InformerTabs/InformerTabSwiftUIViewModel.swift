//
//  InformerTabSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine
import Foundation

@available(iOS 14.0.0, *)
final class InformerTabSwiftUIViewModel: ObservableObject {

    struct TabItem: Hashable {
        let text: String
        let id = UUID().uuidString
        let items: [InformerSegmentedItem]
        var selection: Int
        let title = "то получу в страховом случае"
        let subtitle = "до 1 500 000 ₽"
        let description = "Выгодный вариант для  двухкомнатной квартиры или дачного дома"


        func hash(into hasher: inout Hasher) {
            hasher.combine(selection)
            hasher.combine(title)
            hasher.combine(text)
            hasher.combine(subtitle)
            hasher.combine(description)
        }

        static func == (lhs: TabItem, rhs: TabItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [TabItem]

    // MARK: - Internal Properties

    var title: String {
        "Informer Tabs"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(text: "Two Controls", items: [InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                                 InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц")], selection: 0),
            .init(text: "Three Controls", items: [InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                                  InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                                  InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц")], selection: 0)
        ]
    }

}
