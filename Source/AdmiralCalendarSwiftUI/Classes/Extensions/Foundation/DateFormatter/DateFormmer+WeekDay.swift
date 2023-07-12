//
//  DateFormmer+WeekDay.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import Foundation

extension DateFormatter {
    
    func getShortWeekdaySymbols(_ locale: Locale? = nil) -> [String] {
        if let locale = locale {
            self.locale = locale
        }
        guard let symbols = shortWeekdaySymbols else { return [] }

        let firstWeekday = 2
        return Array(symbols[firstWeekday - 1..<symbols.count]) + symbols[0..<firstWeekday - 1]
    }
    
}
