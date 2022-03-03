//
//  CalendarViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct CalendarViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 820)
    }
    
}

final class CalendarViewSnapshotTests: XCTestCase {
    
    var startDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2019 12 01")!
        return date
    }()
    
    var midlDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2020 06 01")!
        return date
    }()
    
    var endDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2020 11 10")!
        return date
    }()
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testCalendarViewHorizontalDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createCalendarView(type: .horizontal)
        checkCalendarView(view: view, named: "Horizontal.DefaultTheme", testName: "CalendarView")
    }
    
    func testCalendarViewVerticalDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createCalendarView(type: .vertical)
        checkCalendarView(view: view, named: "Vertical.DefaultTheme", testName: "CalendarView")
    }
    
    // MARK: Dark Theme
    
    func testCalendarViewHorizontalDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createCalendarView(type: .horizontal)
        checkCalendarView(view: view, named: "Horizontal.DarkTheme", testName: "CalendarView")
    }
    
    func testCalendarViewVerticalDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createCalendarView(type: .vertical)
        checkCalendarView(view: view, named: "Vertical.DarkTheme", testName: "CalendarView")
    }
    
    func createCalendarView(type: CalendarViewType) -> some View {
        let view = CalendarView(
            type: type,
            startDate: startDate,
            endDate: endDate,
            locale: Locale(identifier: "ru"),
            selectedStartDate: .constant(startDate),
            selectedEndDate: .constant(endDate),
            monthYearDate: midlDate)
        return view
    }
    
}

private extension CalendarViewSnapshotTests {
    
    func checkCalendarView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let calendarViewWrapper = CalendarViewWrapper(view: view)
        let view = UIHostingController(rootView: calendarViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
