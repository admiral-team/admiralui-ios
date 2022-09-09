//
//  CalendarPickerYear.swift
//  AdmiralSwiftUI
//
//  Created by on 31.08.2022.
//

import Foundation

@available(iOS 14.0.0, *)
public struct CalendarPickerYear {

    // MARK: - Public Properties

    /// The title of CalendarPickerYear
    public var title: String

    /// The moths of CalendarPickerYear
    public var months: [CalendarPickerMonth]

    /// The current date of CalendarPickerYear
    public var date: Date = Date()
}
