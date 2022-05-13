//
//  CalendarHorizontalViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class CalendarHorizontalViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var selectedStartDate: Date?
    @Published var selectedEndDate: Date?


    // MARK: - Internal Properties

    var startDate: Date?
    var endDate: Date?

    let dateComponents: DateComponents = {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        dateComponents.year = 2021
        dateComponents.month = 2
        return dateComponents
    }()

    var title: String {
        "Horizontal"
    }

    init(selectedStartDate: Date? = nil, selectedEndDate: Date? = nil) {
        self.selectedStartDate = selectedStartDate
        self.selectedEndDate = selectedEndDate
    }

}
