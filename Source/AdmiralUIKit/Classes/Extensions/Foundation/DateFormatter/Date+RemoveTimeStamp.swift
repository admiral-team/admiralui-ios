//
//  Date+RemoveTimeStamp.swift
//  AdmiralUIKit
//
//  Created on 19.11.2021.
//

import Foundation

extension Date {
    
    func copyDate() -> Date {
        return Date(timeInterval: 0, since: self)
    }
    
    func removeTimeStamp() -> Date {
        var calendar =  Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        if let date = calendar.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) {
            return date
        }
        return copyDate()
    }
    
}

extension Optional where Wrapped == Date {
    
    func copyDate() -> Date? {
        guard let `self` = self else { return nil }
        return Date(timeInterval: 0, since: self)
    }
    
    func removeTimeStamp() -> Date? {
        var calendar =  Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        if let fromDate = self.copyDate(), let date = calendar.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) {
            return date
        }
        return self.copyDate()
    }
    
}

