//
//  CalendarDays.swift
//  AdmiralSwiftUI
//
//  Created by on 31.08.2022.
//

import Foundation

@available(iOS 14.0.0, *)
public struct CalendarDay: Hashable, Identifiable {

    // MARK: - Public Properties

    public let id = UUID()

    /// The date
    public var date: Date

    /// The number
    public var number: String

    /// The selection flag 
    public var isSelected: Bool

    /// The current day flag
    public var isCurrentDay: Bool

    /// The displayed flag
    public var isDisplayedInMonth: Bool

    // MARK: - Initializer

    public init(
        date: Date,
        number: String,
        isSelected: Bool,
        isCurrentDay: Bool,
        isDisplayedInMonth: Bool
    ) {
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
