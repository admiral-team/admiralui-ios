//
//  CalendarWeek.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 18.08.2022.
//

import Foundation

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
