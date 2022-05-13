//
//  StandartTabSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class StandartTabSwiftUIViewModel: ObservableObject {

    struct TabItem: Hashable {
        let title: String
        let id = UUID().uuidString
        let items: [String]
        var selection: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(items)
            hasher.combine(selection)
            hasher.combine(title)
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
        "Standard Tabs"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "Two Controls", items: ["One", "Two"], selection: 0),
            .init(title: "Three Controls", items: ["One", "Two", "Three"], selection: 0)
        ]
    }

}
