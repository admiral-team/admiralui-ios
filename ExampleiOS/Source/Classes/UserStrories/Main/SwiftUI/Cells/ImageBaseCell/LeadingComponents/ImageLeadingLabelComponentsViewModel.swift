//
//  ImageLeadingLabelComponentsViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ImageLeadingLabelComponentsViewModel: ObservableObject {

    struct ImageLabelItem: Hashable {

        enum CellTypeList {
            case title
            case titleSubtitle
            case subtitleTitle
            case titleMoreDetailTextMessage
            case titleSubtitleButton
        }

        let id = UUID().uuidString
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
        "Center Components"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(type: .title),
            .init(type: .titleSubtitle),
            .init(type: .subtitleTitle),
            .init(type: .titleMoreDetailTextMessage),
            .init(type: .titleSubtitleButton)
        ]
    }

}
