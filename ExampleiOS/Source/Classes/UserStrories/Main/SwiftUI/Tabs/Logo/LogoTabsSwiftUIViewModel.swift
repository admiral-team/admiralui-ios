//
//  LogoTabsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import SwiftUI
import Combine
import Foundation

@available(iOS 14.0.0, *)
final class LogoTabsSwiftUIViewModel: ObservableObject {

    struct TabItem: Hashable {
        let title: String
        let id = UUID().uuidString
        let items: [Image]
        var selection: Int

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
        "Logo Tabs"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(
                title: "Two Controls",
                items: [Image(Asset.Tabs.visaLogo.name), Image(Asset.Tabs.masterCardLogo.name)],
                selection: 0
            ),
            .init(
                title: "Three Controls",
                items: [Image(Asset.Tabs.visaLogo.name), Image(Asset.Tabs.masterCardLogo.name), Image(Asset.Tabs.mirLogo.name)],
                selection: 0
            )
        ]
    }

}
