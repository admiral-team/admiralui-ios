//
//  CalendarVerticalSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class CalendarVerticalSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var selectedStartDate: Date?
    @Published var selectedEndDate: Date?

    // MARK: - Internal Properties

    var startDate: Date {
        Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date()
    }
    var endDate: Date {
        Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date()
    }

    var title: String {
        "Vertical"
    }

}
