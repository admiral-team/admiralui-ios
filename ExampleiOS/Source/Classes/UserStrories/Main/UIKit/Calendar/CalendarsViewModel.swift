//
//  CalendarsViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import Foundation

final class CalendarsViewModel {

    enum CalendarsItem: Int, CaseIterable {
        case horizontal
        case vertical

        var title: String {
            switch self {
            case .horizontal:
                return "Horizontal"
            case .vertical:
                return "Vertical"
            }
        }
    }

}
