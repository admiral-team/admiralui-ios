//
//  CaledarDay.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 18.08.2022.
//

import Foundation

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
