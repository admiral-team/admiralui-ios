//
//  Calendar.swift
//  AdmiralUIKit
//
//  Created on 19.11.2021.
//

import Foundation

extension Calendar {
    
    func startOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 1, day: 1))?.removeTimeStamp() ?? Date()
    }
    
    func endOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))?.removeTimeStamp() ?? Date()
    }
    
    func monthDate(by index: Int, date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: index, day: 1))?.removeTimeStamp() ?? Date()
    }
    
    func nextDay(_ date: Date) -> Date {
        return self.date(byAdding: .day, value: 1, to: date).removeTimeStamp() ?? Date()
    }
    
    func nextMonth(_ date: Date) -> Date {
        return self.date(byAdding: .month, value: 1, to: date).removeTimeStamp() ?? Date()
    }
    
    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.month, from: date), month: 1, day: 1))?.removeTimeStamp() ?? Date()
    }
    
}

extension Date {
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
}
