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

    /// The title
    public var title: String

    /// The moths
    public var months: [CalendarPickerMonth]

    /// The current date 
    public var date: Date = Date()
}
