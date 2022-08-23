//
//  CalendarPickerYear.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import Foundation

@available(iOS 14.0.0, *)
public struct CalendarPickerYear {
    var title: String
    var months: [CalendarPickerMonth]
    var date: Date = Date()
}
