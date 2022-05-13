//
//  ClendarsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class CalendarsSwiftUIViewModel: ObservableObject {

    enum CalendarsSwiftUIItem: Int, CaseIterable {
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

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Calendars"
    }

}
