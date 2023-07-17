//
//  CalendarVerticalView.swift
//  AdmiralSwiftUI
//
//  Created on 16.07.2021.
//

import AdmiralTheme
import SwiftUI

/// Calendar view type. Is presented in two versions: Vertical Mode and Horizontal Mode.
public enum CalendarViewType {
    case vertical
    case horizontal
}

/**
 Calendar view let users select a date, or a range of dates.

 This component is presented in two versions: Vertical Mode and Horizontal Mode. Additionally, you can configure parameters
 such as the locale, start date, end date, selected start date, selected end date, the date month that will appear when the calendar appears, and disabled dates after a certain date.

 The vertical calendar can be scrolled vertically, presented in the form of a table and divided into sections. Each section is a specific month.

 A horizontal calendar is a display of the month. Switching between months and years is carried out using the left and right buttons. You can also switch between months using picker view.

 You can create a CalendarView by specifying the following parameters in the initializer
 Initializer parameters:
 - type: Type calendar.
 - startDate: The start date of calendar.
 - endDate: The end date of calendar.
 - locale: Calendar Locolize
 - selectedStartDate: Selected start date of calendar.
 - selectedEndDate: Selected end date of calendar.
 - monthYearDate: The date of moth and year.
 - notActiveAfterDate: Not active after date.
 - isMutlipleSelectionAllowed: The state selection.
 - pointDates: Dates with a dot at the bottom.
 ## Example for the vertical calendar view with disabled dates after a current date:
 # Code
 ```
 CalendarView(
 type: .vertical,
 startDate: startDate,
 endDate: endDate,
 selectedStartDate: $selectedStartDate,
 selectedEndDate: $selectedEndDate,
 monthYearDate: Date(),
 notActiveAfterDate: Date()
 )
 .onChange(of: selectedStartDate, perform: { (_) in })
 .onChange(of: selectedEndDate, perform: { (_) in })
 ```
 You can keep track of the change in the date range using selectedStartDate and selectedEndDate.
 Pay attention to the monthYearDate parameter - this parameter will show the date on the screen in your calendar.
 ## Example for the horizontal calendar view with disabled dates after a current date:
 # Code
 ```
 CalendarView(
 type: .horizontal,
 startDate: startDate,
 endDate: endDate,
 selectedStartDate: $selectedStartDate,
 selectedEndDate: $selectedEndDate,
 monthYearDate: Date(),
 notActiveAfterDate: Date()
 )
 .onChange(of: selectedStartDate, perform: { (_) in })
 .onChange(of: selectedEndDate, perform: { (_) in })
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarView: View {

    // MARK: - Private Properties

    /// Selected start date of calendar.
    @Binding private var selectedStartDate: Date?

    /// Selected end date of calendar.
    @Binding private var selectedEndDate: Date?

    /// The start date of calendar.
    private let startDate: Date?

    /// The end date of calendar.
    private let endDate: Date?

    /// Calendar Locolize
    private let locale: Locale?

    /// The state selection.
    private let isMutlipleSelectionAllowed: Bool

    /// The date of moth and year.
    private let monthYearDate: Date?

    /// Not active after date.
    private let notActiveAfterDate: Date?

    /// Dates with a dot at the bottom.
    private let pointDates: [Date]

    /// Selected dates.
    private let selectedDates: [Date]

    /// Spacing between rows of days.
    private let spacingBetweenRows: CGFloat

    /// Type calendar.
    private let type: CalendarViewType

    /// Horizontal calendar scheme provider serves for changing scheme while change theme.
    private let horizontalSchemeProvider: SchemeProvider<CalendarHorizontalViewScheme>

    /// Vertical calendar scheme provider serves for changing scheme while change theme.
    private let verticalSchemeProvider: SchemeProvider<CalendarVerticalViewScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - type: Type calendar.
    ///   - startDate: The start date of calendar.
    ///   - endDate: The end date of calendar.
    ///   - locale: Calendar Locolize
    ///   - selectedStartDate: Selected start date of calendar.
    ///   - selectedEndDate: Selected end date of calendar.
    ///   - monthYearDate: The date of moth and year.
    ///   - notActiveAfterDate: Not active after date.
    ///   - isMutlipleSelectionAllowed: The state selection.
    ///   - pointDates: Dates with a dot at the bottom.
    ///   - selectedDates: Selected dates.
    public init(
        type: CalendarViewType,
        startDate: Date? = nil,
        endDate: Date? = nil,
        locale: Locale? = nil,
        selectedStartDate: Binding<Date?>,
        selectedEndDate: Binding<Date?>,
        monthYearDate: Date? = nil,
        notActiveAfterDate: Date? = nil,
        isMutlipleSelectionAllowed: Bool = true,
        pointDates: [Date] = [],
        selectedDates: [Date] = [],
        spacingBetweenRows: CGFloat = LayoutGrid.halfModule * 5,
        horizontalSchemeProvider: SchemeProvider<CalendarHorizontalViewScheme> = AppThemeSchemeProvider<CalendarHorizontalViewScheme>(),
        verticalSchemeProvider: SchemeProvider<CalendarVerticalViewScheme> = AppThemeSchemeProvider<CalendarVerticalViewScheme>()
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.locale = locale
        self.monthYearDate = monthYearDate
        self.notActiveAfterDate = notActiveAfterDate
        self._selectedStartDate = selectedStartDate
        self._selectedEndDate = selectedEndDate
        self.isMutlipleSelectionAllowed = isMutlipleSelectionAllowed
        self.type = type
        self.pointDates = pointDates
        self.selectedDates = selectedDates
        self.spacingBetweenRows = spacingBetweenRows
        self.horizontalSchemeProvider = horizontalSchemeProvider
        self.verticalSchemeProvider = verticalSchemeProvider
    }

    // MARK: - Body

    public var body: some View {
        switch type {
        case .horizontal:
            return CalendarHorizontalView(
                startDate: startDate,
                endDate: endDate,
                locale: locale,
                selectedStartDate: $selectedStartDate,
                selectedEndDate: $selectedEndDate,
                monthYearDate: monthYearDate,
                notActiveAfterDate: notActiveAfterDate,
                isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                pointDates: pointDates,
                selectedDates: selectedDates,
                spacingBetweenRows: spacingBetweenRows,
                schemeProvider: horizontalSchemeProvider
            )
            .eraseToAnyView()
        case .vertical:
            return CalendarVerticalView(
                startDate: startDate,
                endDate: endDate,
                locale: locale,
                selectedStartDate: $selectedStartDate,
                selectedEndDate: $selectedEndDate,
                monthYearDate: monthYearDate,
                notActiveAfterDate: notActiveAfterDate,
                isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                pointDates: pointDates,
                selectedDates: selectedDates,
                spacingBetweenRows: spacingBetweenRows,
                schemeProvider: verticalSchemeProvider
            )
            .eraseToAnyView()
        }

    }
}
