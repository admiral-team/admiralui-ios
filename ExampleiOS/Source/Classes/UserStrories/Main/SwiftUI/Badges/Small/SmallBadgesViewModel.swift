//
//  SmallBadgesViewModel.swift
//  ExampleiOS
//
//  Created on 04.04.2022.
//

import AdmiralSwiftUI
import Combine
import Foundation

@available(iOS 14.0.0, *)
final class SmallBadgesViewModel: ObservableObject {

    struct BadgeItem: Identifiable {
        var id: String = UUID().uuidString
        var badgeStyle: BadgeStyle
        var title: String
        var rawValue: Int?
    }

    @Published var items: [BadgeItem]
    @Published var isEnabledControlsState = 0

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    init() {
        items = [
            .init(badgeStyle: .additional, title: "Additional"),
            .init(badgeStyle: .natural, title: "Natural"),
            .init(badgeStyle: .default, title: "Default"),
            .init(badgeStyle: .success, title: "Success"),
            .init(badgeStyle: .error, title: "Error"),
            .init(badgeStyle: .attention, title: "Attention")
        ]
    }

}
