//
//  BadgesSmallViewModel.swift
//  ExampleiOS
//
//  Created on 05.04.2022.
//

import AdmiralUIKit
import Foundation

final class BadgesSmallViewModel {

    struct BadgeItem {
        var title: String
        var style: BadgeStyle
    }

    // MARK: - Properties

    var items: [BadgeItem]

    // MARK: - Computed Properties

    var titles: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            BadgeItem(title: "Additional", style: .additional),
            BadgeItem(title: "Natural", style: .natural),
            BadgeItem(title: "Default", style: .default),
            BadgeItem(title: "Success", style: .success),
            BadgeItem(title: "Error", style: .error),
            BadgeItem(title: "Attention", style: .attention)
        ]
    }

}
