//
//  SwitcherSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 21.04.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class SwitcherSwiftUIViewModel: ObservableObject {

    struct SwitherItem: Identifiable {
        let id = UUID().uuidString
        var text: String
        var isEnabled: Bool
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [SwitherItem]

    // MARK: - Internal Properties

    var title: String {
        "Switcher"
    }

    var tabItems: [String] {
        ["Default", "Disabled"]
    }

    init() {
        items = [
            .init(text: "On", isEnabled: true),
            .init(text: "Off", isEnabled: false)
        ]
    }

}
