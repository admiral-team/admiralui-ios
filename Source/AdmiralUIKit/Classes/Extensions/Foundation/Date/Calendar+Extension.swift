//
//  Calendar+Extension.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import Foundation

extension Date {
    
    func firstDateOfMonth(_ calendar: Calendar = Calendar.current) -> Date? {
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return nil }
        
        var calendar = calendar
        calendar.timeZone = timeZone
        var startDate = Date()
        var interval: TimeInterval = 0
        _ = calendar.dateInterval(of: .month, start: &startDate, interval: &interval, for: self)
        return startDate
    }
    
    func dateToString(dateFormat: String = "yyyy MM dd", locale: Locale? = nil) -> String {
        let format = DateFormatter()
        if let locale = locale {
            format.locale = locale
        }
        format.dateFormat = dateFormat
        return format.string(from: self)
    }
    
}
