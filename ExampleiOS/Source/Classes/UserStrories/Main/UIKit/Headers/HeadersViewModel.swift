//
//  HeadersViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import Foundation

final class HeadersViewModel {

    enum CalendarsItem: Int, CaseIterable {
        case card

        var title: String {
            switch self {
            case .card:
                return "Card"
            }
        }
    }

}
