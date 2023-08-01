//
//  CalendarVerticalView.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0, *)
struct CalendarVerticalView: View {

    // MARK: - Constants

    enum Constants {
        static let offsetY: CGFloat = -0.03
    }

    // MARK: - Public Properties

    /// The start date
    @State var startDate: Date

    /// The end date
    @State var endDate: Date

    /// Calendar loclole
    var locale: Locale?

    /// The state selection.
    @State var isMutlipleSelectionAllowed: Bool = true

    /// Tells that the date at the specified selected.
    @State var didSelectedDate: ((Date?) -> ())?

    /// Tells that the dates at the specified selected.
    @State var didSelectedDates: (([Date]) -> ())?

    /// Selected start date
    @Binding var selectedStartDate: Date?

    /// Selected end date 
    @Binding var selectedEndDate: Date?

    /// The date of moth and year.
    var monthYearDate: Date?

    /// Not active after date.
    var notActiveAfterDate: Date?

    /// Dates with a dot at the bottom.
    let pointDates: [Date]

    /// Selected dates.
    let selectedDates: [Date]

    /// Spacing between rows of days.
    let spacingBetweenRows: CGFloat

    /// Scroll Anchor
    let scrollAnchor: UnitPoint?

    // MARK: - Private Properties

    @State private var dates = [Date]()

    @State private var currentMonthDate: Date?
    @State private var isScrollCalendar: Bool = false

    @ObservedObject var schemeProvider: SchemeProvider<CalendarVerticalViewScheme>

    // MARK: - Initializer

    init(
        startDate: Date? = nil,
        endDate: Date? = nil,
        locale: Locale? = nil,
        selectedStartDate: Binding<Date?> = .constant(nil),
        selectedEndDate: Binding<Date?> = .constant(nil),
        monthYearDate: Date? = nil,
        notActiveAfterDate: Date?,
        isMutlipleSelectionAllowed: Bool = true,
        didSelectedDate: ((Date?) -> ())? = nil,
        didSelectedDates: (([Date]) -> ())? = nil,
        pointDates: [Date],
        selectedDates: [Date],
        spacingBetweenRows: CGFloat = LayoutGrid.halfModule * 5,
        scrollAnchor: UnitPoint? = nil,
        schemeProvider: SchemeProvider<CalendarVerticalViewScheme> = AppThemeSchemeProvider<CalendarVerticalViewScheme>()
    ) {
        if let startDate = startDate {
            self._startDate = .init(initialValue: startDate)
        } else {
            self._startDate = .init(initialValue: Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date())
        }

        if let endDate = endDate {
            self._endDate = .init(initialValue: endDate)
        } else {
            self._endDate = .init(initialValue: Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date())
        }

        self.pointDates = pointDates
        self.selectedDates = selectedDates
        self.spacingBetweenRows = spacingBetweenRows
        self.locale = locale
        self._selectedStartDate = selectedStartDate
        self._selectedEndDate = selectedEndDate
        self.schemeProvider = schemeProvider
        self.scrollAnchor = scrollAnchor
        self.notActiveAfterDate = notActiveAfterDate
        self._isMutlipleSelectionAllowed = .init(initialValue: isMutlipleSelectionAllowed)
        self._didSelectedDate = .init(initialValue: didSelectedDate)
        self._didSelectedDates = .init(initialValue: didSelectedDates)
    }

    // MARK: - Body

    var body: some View {
        let scheme = schemeProvider.scheme
        return ZStack {
            scheme.backgroundColor.swiftUIColor
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    contentListCell()
                }
                .opacity(isScrollCalendar ? 1.0 : 0.0)
                .onAppear {
                    let generator = CalendarGenerator()
                    getDates(
                        generator: generator,
                        startDate: self.startDate,
                        endDate: self.endDate,
                        monthDate: monthYearDate) { dates in
                            self.dates = dates.0
                            self.currentMonthDate = dates.1
                            DispatchQueue.main.async {
                                scrollView.scrollTo(dates.1, anchor: scrollAnchor ?? .center)
                                self.isScrollCalendar = true
                            }
                        }
                    }
                }
            }
    }

    func contentListCell() -> some View {
        LazyVStack(spacing: LayoutGrid.module) {
            ForEach(dates, id: \.self) { date in
                monthView(date: date)
                    .id(date)
            }
        }
    }

    // MARK: - Private Methods

    private func getDates(
        generator: CalendarGenerator,
        startDate: Date,
        endDate: Date,
        monthDate: Date?,
        completion: (_ dates: ([Date], Date?)) -> Void) {
            
            let dates = generator.calculateDates(
                startDate: startDate,
                endDate: endDate,
                monthDate: monthDate)
            
            completion(dates)
        }

    private func monthView(date: Date) -> some View {
        let scheme = schemeProvider.scheme
        let title = date.dateToString(dateFormat: "LLLL yyyy", locale).capitalized
        return VStack(alignment: .leading, spacing: 0) {
            MonthYearView(
                title: title,
                schemeProvider: SchemeProvider.constant(scheme: scheme.monthYearViewScheme)
            )
            Spacer()
                .frame(height: LayoutGrid.halfModule * 5)
            CalendarWeekView(
                locale,
                schemeProvider: SchemeProvider.constant(scheme: scheme.calendarWeekViewScheme)
            )
            Spacer()
                .frame(height: LayoutGrid.halfModule * 5)
            CalendarDaysView(
                date: date,
                isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                startDate: $selectedStartDate,
                endDate: $selectedEndDate,
                notActiveAfterDate: notActiveAfterDate,
                pointDates: pointDates,
                selectedDays: selectedDates,
                spacingBetweenRows: spacingBetweenRows,
                schemeProvider: SchemeProvider.constant(scheme: scheme.calendarViewCellColorScheme)
            )
            Spacer()
                .frame(height: LayoutGrid.halfModule)
            CalendarLine()
                .foregroundColor(scheme.lineBackgroundColor.swiftUIColor)
            Spacer()
                .frame(height: LayoutGrid.halfModule * 3)
        }
    }

}

@available(iOS 14.0, *)
struct CalendarView_Previews: PreviewProvider {

    static var previews: some View {
        CalendarVerticalView(
            startDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!,
            endDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!,
            notActiveAfterDate: Date(),
            pointDates: [],
            selectedDates: []
        )
        .padding()
        .environment(\.manager, SwiftUIThemeManager(theme: .dark))
    }
}
