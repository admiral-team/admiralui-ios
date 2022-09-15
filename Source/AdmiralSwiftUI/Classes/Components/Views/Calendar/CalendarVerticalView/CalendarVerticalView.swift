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
        self.locale = locale
        self._selectedStartDate = selectedStartDate
        self._selectedEndDate = selectedEndDate
        self.schemeProvider = schemeProvider
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
                    LazyVStack(spacing: 0.0) {
                        contentListCell(scheme: scheme, scrollView: scrollView)
                    }
                }
                .opacity(isScrollCalendar ? 1.0 : 0.0)
                .onAppear {
                    let generator = CalendarGenerator()
                    let monthsData = getDates(
                        generator: generator,
                        startDate: self.startDate,
                        endDate: self.endDate,
                        monthDate: monthYearDate)

                    self.dates = monthsData.0
                    self.currentMonthDate = monthsData.1
                    // WORKAROUND: Work for solve problem with scroll.
                    DispatchQueue.main.async {
                        scrollView.scrollTo(monthsData.1)
                        isScrollCalendar = true
                    }
                }
                .padding(.horizontal, LayoutGrid.doubleModule)
            }
        }
    }

    // MARK: - Internal Methods

    func scheme(_ scheme: CalendarVerticalViewScheme) -> some View {
        var view = self
        view.schemeProvider = SchemeProvider.constant(scheme: scheme)
        return view.id(UUID())
    }

    func contentListCell(scheme: CalendarVerticalViewScheme, scrollView: ScrollViewProxy) -> some View {
        ForEach(dates, id: \.self) { date in
            monthView(date: date)
                .id(date)
        }
        .listRowInsets(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        .background(scheme.backgroundColor.swiftUIColor)
        .listRowBackground(scheme.backgroundColor.swiftUIColor)
    }

    // MARK: - Private Methods

    private func getDates(
        generator: CalendarGenerator,
        startDate: Date,
        endDate: Date,
        monthDate: Date?) -> ([Date],Date?) {
            let dates = generator.calculateDates(
                startDate: startDate,
                endDate: endDate,
                monthDate: monthDate)
            return dates
        }

    private func weeks(days: [CalendarDay]) -> [CalendarWeek] {
        var weekDays: [CalendarWeek] = []
        var startIndex = 0
        var endIndex = 6
        let max = (Double(days.count) / 7).rounded(.up)

        for _ in 0..<Int(max) {
            let offset = startIndex...min(endIndex, days.count - 1)
            var days = Array(days[offset])
            if days.count < 7 {
                if let lastDate = days.last?.date {
                    for index in days.count..<7 {
                        if let nextDay = Calendar.current.date(byAdding: .day, value: index, to: lastDate) {
                            days.append(
                                CalendarDay(
                                    date: nextDay,
                                    number: "",
                                    isSelected: false,
                                    isCurrentDay: false,
                                    isDisplayedInMonth: false)
                            )
                        }
                    }
                }
            }
            weekDays.append(CalendarWeek(days: days))
            startIndex += 7
            endIndex += 7
        }
        return weekDays
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
            CalendarDaysView(
                date: date,
                isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                startDate: $selectedStartDate,
                endDate: $selectedEndDate,
                notActiveAfterDate: notActiveAfterDate,
                pointDates: pointDates,
                schemeProvider: SchemeProvider.constant(scheme: scheme.calendarViewCellColorScheme)
            )
            Spacer()
                .frame(height: LayoutGrid.halfModule)
            Line()
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
            startDate: Calendar.current.date(byAdding: .weekOfYear, value: -10, to: Date())!,
            endDate: Calendar.current.date(byAdding: .weekOfYear, value: 10, to: Date())!,
            notActiveAfterDate: Date(),
            pointDates: [])
        .padding()
        .environment(\.manager, SwiftUIThemeManager(theme: .dark))
    }
}
