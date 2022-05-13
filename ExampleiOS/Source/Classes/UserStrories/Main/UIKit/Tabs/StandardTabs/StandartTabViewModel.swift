//
//  StandartTabViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class StandartTabViewModel {

    struct TabItem {
        let text: String
        let items: [String]
        var selection: Int
    }

    // MARK: - Published Properties

    var items: [TabItem]

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
            TabItem(
                text: "Two controls",
                items: ["One", "Two"],
                selection: 0
            ),
            TabItem(
                text: "Three Controls",
                items: ["One", "Two", "Three"],
                selection: 0
            )
        ]
    }

}
