//
//  SwitcherViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import Foundation

final class SwitcherViewModel {

    struct SwitherItem {
        var text: String
        var isEnabled: Bool
    }

    // MARK: - Internal Properties

    var items: [SwitherItem]

    // MARK: - Internal Properties

    var title: String {
        "Switcher"
    }

    var tabItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            SwitherItem(text: "On", isEnabled: true),
            SwitherItem(text: "Off", isEnabled: false)
        ]
    }

}
