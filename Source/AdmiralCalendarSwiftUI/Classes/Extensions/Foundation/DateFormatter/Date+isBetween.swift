//
//  Date+isBetween.swift
//  AdmiralCalendarSwiftUI
//
//  Created by on 13.07.2023.
//  
//

import Foundation

extension Date {
    func isBetween(in rangeOfDates: [Date]) -> Bool {
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return false }

        var calendar = Calendar.current
        calendar.timeZone = timeZone

        let sortedDates = rangeOfDates
            .sorted(by: { $0.compare($1) == .orderedAscending })
            .map { calendar.startOfDay(for: $0)}

        guard let starDateInfRange = sortedDates.first, let endDateInRange = sortedDates.last else { return false }

        let range = starDateInfRange...endDateInRange
        return range.contains(self)
    }
}
