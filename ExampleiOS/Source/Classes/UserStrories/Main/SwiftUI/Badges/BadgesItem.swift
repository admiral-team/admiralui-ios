//
//  BadgesItem.swift
//  ExampleiOS
//
//  Created on 04.04.2022.
//

@available(iOS 14.0, *)
enum BadgesItem: CaseIterable {
    case normal
    case small

    var title: String {
        switch self {
        case .normal:
            return "Normal"
        case .small:
            return "Small"
        }
    }
}
