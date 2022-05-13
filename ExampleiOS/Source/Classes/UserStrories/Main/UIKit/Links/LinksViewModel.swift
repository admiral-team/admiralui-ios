//
//  LinksViewModel.swift
//  ExampleiOS
//
//  Created on 08.05.2022.
//

import AdmiralUIKit
import Foundation
import UIKit

final class LinksViewModel {

    final class LinksSection {

        // MARK: - Properties

        let type: String
        let links: [LinkItem]

        // MARK: - Initializer

        init(type: String, links: [LinkItem] = []) {
            self.type = type
            self.links = links
        }
    }

    struct LinkItem {
        enum Position {
            case leading
            case trailing
        }

        let style: TagStyle
        let fontStyle: BaseLinkControl.FontStyle
        let text: String
        let image: UIImage?
        let title: String
        let position: Position?
    }

    // MARK: - Internal Properties

    var links: [LinksSection]

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
            LinksSection(type: "24 Link", links: [
                .init(style: .none, fontStyle: .body, text: "Link", image: Asset.Links.arrowLeftBig.image, title: "Small Button", position: .leading),
                .init(style: .none, fontStyle: .body, text: "Link", image: Asset.Links.arrowRightBig.image, title: "Small Button", position: .trailing),
                .init(style: .none, fontStyle: .body, text: "Link", image: nil, title: "Small Button", position: nil)
            ]),
            LinksSection(type: "18 Link", links: [
                .init(style: .none, fontStyle: .subhead, text: "Link", image: Asset.Links.arrowLeftSmall.image, title: "Small Button", position: .leading),
                .init(style: .none, fontStyle: .subhead, text: "Link", image: Asset.Links.arrowRightSmall.image, title: "Small Button", position: .trailing),
                .init(style: .none, fontStyle: .subhead, text: "Link", image: nil, title: "Small Button", position: nil)
            ])
        ]
    }

}
