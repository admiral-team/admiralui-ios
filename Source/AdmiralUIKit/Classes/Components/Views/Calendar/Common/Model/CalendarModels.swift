//
//  CalendarModels.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import Foundation

struct Month {
    var days: [Day]
    let title: String
}

class Day {
    let date: Date
    let number: String
    var isSelected: Bool
    let isCurrentDay: Bool
    let isDisplayedInMonth: Bool
    
    init(date: Date, number: String, isSelected: Bool, isCurrentDay: Bool, isDisplayedInMonth: Bool) {
        self.date = date
        self.number = number
        self.isSelected = isSelected
        self.isCurrentDay = isCurrentDay
        self.isDisplayedInMonth = isDisplayedInMonth
    }
}
