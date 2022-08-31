//
//  CalendarWeek.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 31.08.2022.
//

import Foundation

@available(iOS 14.0.0, *)
public struct CalendarWeek: Hashable, Identifiable {

    // MARK: - Internal Properties

    public let id = UUID()

    /// The days of weel
    public var days: [CalendarDay]

    // MARK: - Initializer

    public init(days: [CalendarDay]) {
        self.days = days
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
