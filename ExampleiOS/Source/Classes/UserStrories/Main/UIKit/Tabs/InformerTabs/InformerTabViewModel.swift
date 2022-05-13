//
//  InformerTabViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class InformerTabViewModel {

    struct TabItem {
        let text: String
        let items: [InformerTab]
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
            TabItem(text: "Two Controls", items: [InformerTab(title: "2 900 ₽", subtitle: "в месяц"),
                                                InformerTab(title: "2 900 ₽", subtitle: "в месяц")], selection: 0),
            TabItem(text: "Three Controls", items: [InformerTab(title: "2 900 ₽", subtitle: "в месяц"),
                                                  InformerTab(title: "2 900 ₽", subtitle: "в месяц"),
                                                  InformerTab(title: "2 900 ₽", subtitle: "в месяц")], selection: 0)
        ]
    }

}
