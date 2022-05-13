//
//  ImageLabelComponentsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ImageLabelComponentsSwiftUIViewModel: ObservableObject {

    struct ImageLabelItem: Hashable {

        enum CellTypeList {
            case imageCardListView(image: Image)
            case imageListView(image: Image)
            case imageNameListView(title: String)
            case imageBackgroundListView(image: Image)
        }

        let id = UUID().uuidString
        let title: String
        let type: CellTypeList

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: ImageLabelItem, rhs: ImageLabelItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var selectedIndex: Int?
    @Published var isEnabledControlsState: Int = 0
    @Published var items: [ImageLabelItem]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Leading Components"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "Card Place", type: .imageCardListView(image: Image(uiImage: Asset.Card.visa.image))),
            .init(title: "Lable Place", type: .imageListView(image: Image(uiImage: Asset.Card.imageCard.image))),
            .init(title: "Icon Name", type: .imageNameListView(title: "IN")),
            .init(title: "Icon Place vs Background", type: .imageBackgroundListView(image: Image(uiImage: Asset.Main.gem.image))),
            .init(title: "Icon Place", type: .imageListView(image: Image(uiImage: Asset.Main.gem.image)))
        ]
    }

}
