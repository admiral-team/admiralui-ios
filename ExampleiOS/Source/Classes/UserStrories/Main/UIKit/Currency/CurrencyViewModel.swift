//
//  CurrencyViewModel.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import Foundation

final class CurrencyViewModel {

    enum Items: CaseIterable {
        case `default`
        case icons
        case flags
        case iconsAndFlags

        func getTitle() -> String {
            switch self {
            case .default:
                return "Default"
            case .icons:
                return "Icons"
            case .flags:
                return "Flags"
            case .iconsAndFlags:
                return "Icons & Flags"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
