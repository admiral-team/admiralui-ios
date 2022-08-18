//
//  CalendarMonth.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 18.08.2022.
//

import Foundation

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
