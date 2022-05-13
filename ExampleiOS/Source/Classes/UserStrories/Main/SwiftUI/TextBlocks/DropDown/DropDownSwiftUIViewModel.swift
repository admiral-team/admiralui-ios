//
//  DropDownSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 25.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class DropDownSwiftUIViewModel: ObservableObject {

    enum DropDownItem: Hashable {
        case titleButtonDropDown(title: String, buttonTitle: String)
        case buttonDropDown(buttonTitle: String, dropDownHeaderType: DropDownHeaderType)

        static func == (lhs: DropDownItem, rhs: DropDownItem) -> Bool {
            switch (lhs, rhs) {
            case (.titleButtonDropDown, .titleButtonDropDown), (.buttonDropDown, .buttonDropDown):
                return true
            default:
                return false
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case .titleButtonDropDown(let title, let buttonTitle):
                hasher.combine(title)
                hasher.combine(buttonTitle)
            case .buttonDropDown(let buttonTitle, _):
                hasher.combine(buttonTitle)
            }
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0

    @Published var items: [DropDownItem]

    // MARK: - Internal Properties

    var title: String {
        "Accordion"
    }

    init() {
        items = [
            .buttonDropDown(buttonTitle: "Button", dropDownHeaderType: .down),
            .titleButtonDropDown(title: "Title", buttonTitle: "Button")
        ]
    }

}
