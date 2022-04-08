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
    
    enum Constants {
        static let offsetY: CGFloat = -0.03
    }
    
    // MARK: - Public Properties
    
    /// The start date of calendar.
    @State var startDate: Date
    
    /// The end date of calendar.
    @State var endDate: Date
    
    /// Calendar loclole
    var locale: Locale?
    
    /// The state selection.
    @State var isMutlipleSelectionAllowed: Bool = true
    
    /// Tells that the date at the specified selected.
    @State var didSelectedDate: ((Date?) -> ())?
    
    /// Tells that the dates at the specified selected.
    @State var didSelectedDates: (([Date]) -> ())?
    
    /// Selected start date of calendar.
    @Binding var selectedStartDate: Date?
    
    /// Selected end date of calendar.
    @Binding var selectedEndDate: Date?
    
    /// The date of moth and year.
    var monthYearDate: Date?
    
    /// Not active after date.
    var notActiveAfterDate: Date?
    
    /// Dates with a dot at the bottom.
    let pointDates: [Date]
    
    // MARK: - Private Properties
    
    @State private var months = [Month]()
    
    @State private var selectDate: Date?
    @State private var privateSelectedStartDate: Date?
    @State private var privateSelectedEndDate: Date?
    @State private var scheme: CalendarVerticalViewScheme? = nil
    @State private var currentMonthIndex: Int?
    @State private var isInitCalendar: Bool = false
    @State private var isScrollCalendar: Bool = false
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<CalendarVerticalViewScheme>()

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
        pointDates: [Date]) {
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
            
            if selectedStartDate.wrappedValue != nil {
                self._privateSelectedStartDate = .init(initialValue: selectedStartDate.wrappedValue)
            }
            if selectedEndDate.wrappedValue != nil {
                self._privateSelectedEndDate = .init(initialValue: selectedEndDate.wrappedValue)
            }
            
            self.notActiveAfterDate = notActiveAfterDate
            self._isMutlipleSelectionAllowed = .init(initialValue: isMutlipleSelectionAllowed)
            self._didSelectedDate = .init(initialValue: didSelectedDate)
            self._didSelectedDates = .init(initialValue: didSelectedDates)
            
        
            let monthsData = preInitData()
            
            self._months = .init(initialValue: monthsData.0)
            self._currentMonthIndex = .init(initialValue: monthsData.1)
        }
    
    var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return ZStack {
            scheme.backgroundColor.swiftUIColor
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(spacing: 0.0) {
                        contentListCell(scheme: scheme, scrollView: scrollView)
                    }
                }
                .onAppear {
                    guard !isInitCalendar,
                          let currentMonthIndex = currentMonthIndex,
                          currentMonthIndex < months.count else { return }
                    
                    let queue = DispatchQueue.global(qos: .userInteractive)
                    queue.async {
                        let generator = CalendarGenerator()
                        let monthsData = getMonths(
                            generator: generator,
                            startDate: startDate,
                            endDate: endDate,
                            monthDate: monthYearDate)
                        
                        DispatchQueue.main.async {
                            self.months = monthsData.0
                            self.currentMonthIndex = monthsData.1
                            self.isInitCalendar = true
                        }
                    }
                    // WORKAROUND: Work for solve problem with scroll.
                    scrollView.scrollTo(self.months[currentMonthIndex].id, anchor: .init(x: 0.0, y: Constants.offsetY))
                }
                .padding(.horizontal, LayoutGrid.doubleModule)
            }
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: CalendarVerticalViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    func contentListCell(scheme: CalendarVerticalViewScheme, scrollView: ScrollViewProxy) -> some View {
        ForEach(months, id: \.id) { month in
            monthView(month: month)
                .id(month.id)
                .onAppear {
                    if isInitCalendar, !isScrollCalendar {
                        if month.id == self.months[self.currentMonthIndex ?? 0].id {
                            isScrollCalendar = true
                        }
                        // WORKAROUND: Work for solve problem with scroll.
                        scrollView.scrollTo(self.months[self.currentMonthIndex ?? 0].id, anchor: .init(x: 0.0, y: Constants.offsetY))
                    }
                }
        }
        .listRowInsets(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        .background(scheme.backgroundColor.swiftUIColor)
        .listRowBackground(scheme.backgroundColor.swiftUIColor)
    }
    
    // MARK: - Private Methods
    
    private func getMonths(
        generator: CalendarGenerator,
        startDate: Date,
        endDate: Date,
        monthDate: Date?) -> ([Month],Int,[CalendarPickerYear], [Int : (Int, Int)]) {
        let monthsData = generator.calculateMonthsData(
            startDate: startDate,
            endDate: endDate,
            monthDate: monthDate)
        return monthsData
    }
    
    private func weeks(days: [Day]) -> [Week] {
        var weekDays: [Week] = []
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
                                Day(
                                    date: nextDay,
                                    number: "",
                                    isSelected: false,
                                    isCurrentDay: false,
                                    isDisplayedInMonth: false))
                        }
                    }
                }
            }
            weekDays.append(Week(days: days))
            startIndex += 7
            endIndex += 7
        }
        return weekDays
    }
    
    private func monthView(month: Month) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return VStack(alignment: .leading, spacing: 0) {
            MonthYearView(title: month.title)
            Spacer()
                .frame(height: LayoutGrid.halfModule * 5)
            CalendarWeekView(locale)
            Spacer()
                .frame(height: LayoutGrid.halfModule * 5)
            // TODO: - change CalendarVerticalDaysView to CalendarlDaysView
            CalendarVerticalDaysView(
                days: month.days,
                startDate: selectedStartDate,
                endDate: selectedEndDate,
                notActiveAfterDate: notActiveAfterDate,
                pointDates: pointDates) { day in
                let date = day.date

                isMutlipleSelectionAllowed ? prepareMultipleSelectionDates(date: date) : prepareSingleSelectionDate(date: date)
            }
            Spacer()
                .frame(height: LayoutGrid.halfModule)
            Line()
                .foregroundColor(scheme.lineBackgroundColor.swiftUIColor)
            Spacer()
                .frame(height: LayoutGrid.halfModule * 3)
        }
    }
    
    private func preInitData() -> ([Month], Int) {
        var preStartDate = Date()
        var preEndDate = Date()
        
        if let monthYearDate = monthYearDate {
            if self.startDate < monthYearDate,  monthYearDate < self.endDate {
                if let calendarStartDate = Calendar.current.date(byAdding: .month, value: -1, to: monthYearDate), self.startDate < calendarStartDate {
                    preStartDate = calendarStartDate
                } else {
                    preStartDate = self.startDate
                }
                
                if let calendarEndDate = Calendar.current.date(byAdding: .month, value: 1, to: monthYearDate), self.endDate > calendarEndDate {
                    preEndDate = calendarEndDate
                } else {
                    preEndDate = self.endDate
                }
                
                preEndDate = monthYearDate
            } else {
                if let calendarStartDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()), self.startDate < calendarStartDate {
                    preStartDate = calendarStartDate
                } else {
                    preStartDate = self.startDate
                }
                
                if let calendarEndDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()), self.endDate > calendarEndDate {
                    preEndDate = calendarEndDate
                } else {
                    preEndDate = self.endDate
                }
            }
        }
        else if self.startDate < Date(),  Date() < self.endDate {
            if let calendarStartDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()), self.startDate < calendarStartDate {
                preStartDate = calendarStartDate
            } else {
                preStartDate = self.startDate
            }
            
            if let calendarEndDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()), self.endDate > calendarEndDate {
                preEndDate = calendarEndDate
            } else {
                preEndDate = self.endDate
            }
        } else {
            preStartDate = self.endDate
            preEndDate = self.endDate
        }
        
        var generator = CalendarGenerator()
        generator.locale = locale
        let monthsData = getMonths(
            generator: generator,
            startDate: preStartDate,
            endDate: preEndDate,
            monthDate: monthYearDate)
        
        return (monthsData.0, monthsData.1)
    }
    
    private func getMonthsValue(generator: CalendarGenerator) -> ([Month],Int,[CalendarPickerYear],[Int : (Int, Int)]) {
        let monthsValue = generator.calculateMonthsData(
            startDate: self.startDate,
            endDate: self.endDate)
        return monthsValue
    }
    
    private func prepareMultipleSelectionDates(date: Date) {
        defer {
            selectedStartDate = privateSelectedStartDate
            selectedEndDate = privateSelectedEndDate
            //didSelectedDates?(selectedDates)
        }
        
        if let startDate = privateSelectedStartDate,
            let endDate = privateSelectedEndDate,
            startDate <= date, endDate >= date {
            privateSelectedStartDate = date
            privateSelectedEndDate = nil
            return
        }
        
        if let startDate = privateSelectedStartDate,
           let _ = privateSelectedEndDate {
            
            if startDate > date {
                privateSelectedStartDate = date
            } else {
                privateSelectedEndDate = date
            }
            return
        } else if let startDate = privateSelectedStartDate {
            
            if startDate > date {
                privateSelectedEndDate = privateSelectedStartDate
                privateSelectedStartDate = date
            } else {
                privateSelectedEndDate = date
            }
        } else {
            self.privateSelectedStartDate = date
        }
    }
    
    private func prepareSingleSelectionDate(date: Date) {
        if
            let selectedStartDate = privateSelectedStartDate,
            selectedStartDate == date {
            self.privateSelectedStartDate = nil
        } else {
            privateSelectedStartDate = date
        }
        
        didSelectedDate?(privateSelectedStartDate)
    }
    
    private func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            guard let date = Calendar.current.date(
                    byAdding: .day,
                    value: 1,
                    to: tempDate)
            else { return array }
            
            tempDate = date
            array.append(tempDate)
        }
        return array
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
