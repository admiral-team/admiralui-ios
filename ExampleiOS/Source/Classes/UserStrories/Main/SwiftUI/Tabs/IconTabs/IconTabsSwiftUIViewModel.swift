//
//  IconTabsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class IconTabsSwiftUIViewModel: ObservableObject {

    struct TabItem: Hashable {

        enum TabType {
            case `default`
            case scroll
        }

        let title: String
        let id = UUID().uuidString
        let items: [IconTabModel]
        var selection: Int
        var type: TabType = .default

        func hash(into hasher: inout Hasher) {
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
        "Icon Tabs"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(
                title: "Two Controls",
                items: [
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.mobile.image),
                        text: "One"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.card.image),
                        text: "Two"
                    )
                ],
                selection: 0
            ),
            .init(
                title: "Three Controls",
                items: [
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.mobile.image),
                        text: "One"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.card.image),
                        text: "Two"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.account.image),
                        text: "Three"
                    )
                ],
                selection: 0
            ),
            .init(
                title: "Embedded in ScrollView",
                items: [
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.mobile.image),
                        text: "One"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.card.image),
                        text: "Two"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.account.image),
                        text: "Three"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.account.image),
                        text: "Four"
                    ),
                    IconTabModel(
                        image: Image(uiImage: Asset.IconTabs.account.image),
                        text: "Five"
                    )
                ],
                selection: 0,
                type: .scroll
            )
        ]
    }

}
