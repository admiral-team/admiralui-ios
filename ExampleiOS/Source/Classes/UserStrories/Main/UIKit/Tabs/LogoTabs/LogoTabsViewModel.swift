//
//  LogoTabsViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation
import UIKit

final class LogoTabsViewModel {

    struct TabItem {
        let text: String
        let images: [UIImage]
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
                images: [Asset.Tabs.visaLogo.image,
                         Asset.Tabs.masterCardLogo.image],
                selection: 0
            ),
            TabItem(
                text: "Three Controls",
                images: [Asset.Tabs.visaLogo.image,
                         Asset.Tabs.masterCardLogo.image,
                         Asset.Tabs.mirLogo.image],
                selection: 0
            )
        ]
    }

}
