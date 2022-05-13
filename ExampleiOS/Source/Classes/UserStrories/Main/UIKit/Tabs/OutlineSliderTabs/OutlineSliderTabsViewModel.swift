//
//  OutlineSliderTabsViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class OutlineSliderTabsViewModel {

    struct TabItem {
        let text: String
        let items: [String]
        var selection: Int
        let isScrollEnabled: Bool
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
                text: "Three controls",
                items: ["One", "Two", "Three"],
                selection: 0,
                isScrollEnabled: false
            ),
            TabItem(
                text: "Slider Controls",
                items: ["One", "Two", "Three",
                    "Four", "Five", "Six",
                    "Seven", "Eight", "Nine"],
                selection: 0,
                isScrollEnabled: true
            )
        ]
    }

}
