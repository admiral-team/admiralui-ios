//
//  LinksSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 21.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class LinksSwiftUIViewModel: ObservableObject {

    final class LinksSection {

        enum LinkType {
            case small(title: String)
            case medium(title: String)
        }

        // MARK: - Properties

        let type: LinkType
        let links: [LinkItem]

        // MARK: - Initializer

        init(type: LinkType, links: [LinkItem] = []) {
            self.type = type
            self.links = links
        }
    }

    struct LinkItem: Hashable {
        let id = UUID().uuidString
        let style: LinkControlStyle
        let text: String
        let image: Image?
        let title: String
        let direction: LinkControlDirection

        func hash(into hasher: inout Hasher) {
            hasher.combine(style)
            hasher.combine(text)
            hasher.combine(direction)
        }

        static func == (lhs: LinkItem, rhs: LinkItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var links: [LinksSection]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Links"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        links = [
            LinksSection(type: .medium(title: "24 Link"), links: [
                .init(style: .default, text: "Link", image: Image(uiImage: Asset.Links.arrowLeftBig.image), title: "Small Button", direction: .left),
                .init(style: .default, text: "Link", image: Image(uiImage: Asset.Links.arrowRightBig.image), title: "Small Button", direction: .right),
                .init(style: .default, text: "Link", image: nil, title: "Small Button", direction: .left)
            ]),
            LinksSection(type: .small(title: "18 Link"), links: [
                .init(style: .medium, text: "Link", image: Image(uiImage: Asset.Links.arrowLeftSmall.image), title: "Small Button", direction: .left),
                .init(style: .medium, text: "Link", image: Image(uiImage: Asset.Links.arrowRightSmall.image), title: "Small Button", direction: .right),
                .init(style: .medium, text: "Link", image: nil, title: "Small Button", direction: .left)
            ])
        ]
    }

}
