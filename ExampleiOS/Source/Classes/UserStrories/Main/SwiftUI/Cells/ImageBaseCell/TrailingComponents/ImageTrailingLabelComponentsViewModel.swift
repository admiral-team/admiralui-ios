//
//  ImageTrailingLabelComponentsViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class ImageTrailingLabelComponentsViewModel: ObservableObject {

    struct TrailingComponentItem: Hashable {

        enum CellTypeList {
            case title
            case radioButton
            case checkBoxListView
            case switchListView
            case iconListView
            case cardListView
            case datePercentListView
            case imageWithSubtitleListView
            case subtitleWithImageListView
        }

        let id = UUID().uuidString
        let type: CellTypeList

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: TrailingComponentItem, rhs: TrailingComponentItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isRadioButtonListViewControlSelected = true
    @Published var isCheckBoxViewControlSelected = true
    @Published var isSwitchSelected = true

    @Published var selectedIndex: Int?
    @Published var isEnabledControlsState: Int = 0
    @Published var items: [TrailingComponentItem]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Trailing elements"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(type: .title),
            .init(type: .radioButton),
            .init(type: .checkBoxListView),
            .init(type: .switchListView),
            .init(type: .iconListView),
            .init(type: .cardListView),
            .init(type: .datePercentListView),
            .init(type: .imageWithSubtitleListView),
            .init(type: .subtitleWithImageListView)
        ]
    }

}
