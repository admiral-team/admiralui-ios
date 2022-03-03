//
//  CalendarModels.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import Foundation

@available(iOS 14.0.0, *)
public struct CalendarPickerYear {
    var title: String
    var months: [CalendarPickerMonth]
    var date: Date = Date()
}

@available(iOS 14.0.0, *)
public struct CalendarPickerMonth {
    var title: String
    var index: Int
    var year: String
    var date: Date
}


@available(iOS 14.0.0, *)
public struct Month: Hashable, Identifiable {
    
    public let id = UUID()
    public var days: [Day]
    public var title: String
    public var date: Date
    
    public init(days: [Day], title: String, date: Date) {
        self.days = days
        self.title = title
        self.date = date
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(days)
        hasher.combine(title)
    }
}

@available(iOS 14.0.0, *)
struct Week: Hashable, Identifiable {
    let id = UUID()
    var days: [Day]
    
    init(days: [Day]) {
        self.days = days
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


@available(iOS 14.0.0, *)
public struct Day: Hashable, Identifiable {
    
    public let id = UUID()
    public var date: Date
    public var number: String
    public var isSelected: Bool
    public var isCurrentDay: Bool
    public var isDisplayedInMonth: Bool
    
    public init(date: Date, number: String, isSelected: Bool, isCurrentDay: Bool, isDisplayedInMonth: Bool) {
        self.date = date
        self.number = number
        self.isSelected = isSelected
        self.isCurrentDay = isCurrentDay
        self.isDisplayedInMonth = isDisplayedInMonth
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
