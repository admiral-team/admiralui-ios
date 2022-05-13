//
//  IconTabsViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class IconTabsViewModel {

    struct TabItem {
        let text: String
        let items: [IconTab]
        var selection: Int
    }

    // MARK: - Published Properties

    var items: [TabItem]

    // MARK: - Internal Properties

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            TabItem(
                text: "Two controls",
                items: [IconTab(title: "One", image: Asset.IconTabs.mobile.image),
                        IconTab(title: "Two", image: Asset.IconTabs.card.image)],
                selection: 0
            ),
            TabItem(
                text: "Three Controls",
                items: [IconTab(title: "One", image: Asset.IconTabs.mobile.image),
                        IconTab(title: "Two", image: Asset.IconTabs.card.image),
                        IconTab(title: "Three", image: Asset.IconTabs.account.image)],
                selection: 0
            )
        ]
    }

}
