//
//  CurrencySwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class CurrencySwiftUIViewModel: ObservableObject {

    enum CurrencySwiftUIViewItem: Int, CaseIterable {
        case `default`
        case icons
        case flags
        case iconsFlags

        var title: String {
            switch self {
            case .default:
                return "Default"
            case .icons:
                return "Icons"
            case .flags:
                return "Flags"
            case .iconsFlags:
                return "Icons & Flags"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Currency"
    }

}
