//
//  UnderLineSliderTabsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine
import Foundation

@available(iOS 14.0.0, *)
final class UnderLineSliderTabsSwiftUIViewModel: ObservableObject {

    struct TabItem: Hashable {
        let title: String
        let id = UUID().uuidString
        var items: [UnderlineTabItem]
        var selection: Int

        init(
            title: String,
            items: [String],
            selection: Int
        ) {
            self.selection = selection
            self.title = title
            self.items = items.map({ UnderlineTabItem(title: $0, badgeStyle: nil) })
        }

        init(
            title: String,
            items: [UnderlineTabItem],
            selection: Int
        ) {
            self.selection = selection
            self.title = title
            self.items = items
        }


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
    @Published var isStaticControlsState: Int = 0
    @Published var items: [TabItem]

    // MARK: - Internal Properties

    var title: String {
        "Underline Slider Tabs"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "Two Controls", items: [UnderlineTabItem(title: "One", badgeStyle: .default),
                                                 UnderlineTabItem(title: "Two", badgeStyle: nil),
                                                 UnderlineTabItem(title: "Three", badgeStyle: .default)], selection: 0),
            .init(title: "Scroll Controls", items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"], selection: 0)
        ]
    }

}
