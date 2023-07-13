//
//  CalendarMonth.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2022.
//

import Foundation

@available(iOS 14.0.0, *)
public struct Month: Hashable, Identifiable {

    // MARK: - Public Properties

    public let id = UUID()

    /// The days
    public var days: [CalendarDay]

    /// The title
    public var title: String

    /// The current date
    public var date: Date

    // MARK: - Initializer

    public init(days: [CalendarDay], title: String, date: Date) {
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
