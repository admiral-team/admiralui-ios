//
//  CalendarGenerator.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import Foundation

public struct MonthMetadata {
    let numberOfDays: Int
    let firstDay: Date
    let firstDayWeekday: Int
}

enum CalendarDataError: Error {
    case metadataGeneration
}

@available(iOS 14.0.0, *)
protocol CalendarGeneratorDelegate {
    var currentMonthIndex: Int { get }
    var currentDayIndex: Int { get }
    func compareDate(firstDate: Date,
                     secondDate: Date,
                     with granularity: Calendar.Component,
                     byOrder order: ComparisonResult) -> Bool
}

@available(iOS 14.0.0, *)
public struct CalendarGenerator: CalendarGeneratorDelegate {
    
    // MARK: - Public Properties
    
    var currentMonthIndex: Int = 0
    var currentDayIndex: Int = 0
    var currentDay: Date?
    var locale: Locale? {
        didSet { updateLocale() }
    }
    
    // MARK: - Private Properties
    
    private var months: [String] = []
    private var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        return calendar
    }()
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    public init() {
        calculateMonth()
    }
    
    // MARK: - Public Methods
    
    func compareDate(firstDate: Date,
                     secondDate: Date,
                     with granularity: Calendar.Component = .day,
                     byOrder order: ComparisonResult = .orderedSame) -> Bool {
        return calendar.compare(firstDate, to: secondDate, toGranularity: granularity) == order
    }
    
    public func calculatePreviousMonthData(currentDate: Date, startDate: Date?) -> Date? {
        let localStartDate = startDate ?? Calendar.current.date(byAdding: .year, value: -1, to: currentDate) ?? Date()
        let preMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)
        let distantPast: Date = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            let date = formatter.date(from: "1 01 01") !! fatalError("Invalid date")
            return date
        }()
        guard let preMonth = preMonth,
              preMonth > localStartDate,
              preMonth > distantPast else { return nil }
        return preMonth
    }
    
    public func calculateNextMonthData(currentDate: Date, endDate: Date?) -> Date? {
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? Date()
        let endFinalDate =  Calendar.current.nextMonth(nextMonthDate).startOfMonth().removeTimeStamp()
        guard nextMonthDate < endFinalDate else { return nil }
        return nextMonthDate
    }
    
    public func calculateInitPickerData(
        startInitDate: Date,
        endInitDate: Date,
        startDate: Date?,
        endDate: Date?) -> [CalendarPickerYear]? {
            let toDate = (Calendar.current.date(byAdding: .month, value: 1, to: endInitDate) ?? Date()).removeTimeStamp()
            guard let totalYears = calendar.dateComponents([.year],
                                                            from: startInitDate,
                                                            to: Calendar.current.endOfYear(toDate)).year else {
                return nil }
            
            return calculatePickerData(totalYears: totalYears, toDate: startInitDate, startDate: startDate, endDate: endDate, isInitState: true)
        }
    
    public func calculateStartPickerData(
        startDate: Date?,
        pickerStartDate: Date) -> [CalendarPickerYear]? {
            let localStartDate = max(startDate ?? Calendar.current.date(byAdding: .year, value: -800, to: pickerStartDate) ?? Date(), Date.distantPast)
            let calendarDate = max(Calendar.current.date(byAdding: .year, value: -400, to: pickerStartDate) ?? pickerStartDate, Date.distantPast)
            let startDateOfYear = Calendar.current.startOfYear(calendarDate)
            let fromDateOfYear = Calendar.current.date(byAdding: .year, value: -1, to: startDateOfYear) ?? Date()
            
            var preDate: Date
            if startDateOfYear > localStartDate {
                preDate = fromDateOfYear.removeTimeStamp()
            } else if pickerStartDate.removeTimeStamp() != localStartDate.startOfMonth().removeTimeStamp() {
                preDate = localStartDate.removeTimeStamp()
            } else {
                return nil
            }
            let fromDate = (Calendar.current.date(byAdding: .year, value: -1, to: preDate) ?? Date()).removeTimeStamp()
            let offset = calendarDate == Date.distantPast ? 0 : -1
            let toDate = (Calendar.current.date(byAdding: .year, value: offset, to: pickerStartDate) ?? Date()).removeTimeStamp()
            guard localStartDate.removeTimeStamp() <= preDate.removeTimeStamp(),
                    let totalMonths = calendar.dateComponents([.year],
                                                      from: fromDate,
                                                      to: toDate).year, totalMonths > 0 else {
                return nil }
            
            return calculatePickerData(totalYears: totalMonths, toDate: preDate, startDate: startDate, endDate: nil)
    }
    
    public func calculateEndPickerData(
        endDate: Date?,
        pickerEndDate: Date) -> [CalendarPickerYear]? {
            let localEndDate = endDate ?? Calendar.current.date(byAdding: .year, value: 800, to: pickerEndDate) ?? Date()
            let calendarDate = Calendar.current.date(byAdding: .year, value: 400, to: pickerEndDate)
            let startDateOfYear = Calendar.current.startOfYear(calendarDate ?? pickerEndDate)
            var toDate: Date
            if startDateOfYear < localEndDate {
                toDate = startDateOfYear
            } else if pickerEndDate.removeTimeStamp() != localEndDate.startOfMonth().removeTimeStamp() {
                toDate = localEndDate
            } else {
                return nil
            }
            let fromDate = (Calendar.current.date(byAdding: .year, value: 1, to: pickerEndDate) ?? Date()).removeTimeStamp()
            guard localEndDate >= toDate, let totalMonths = calendar.dateComponents([.year],
                                                      from: fromDate,
                                                      to: toDate).year, totalMonths > 0 else {
                return nil }
            
            return calculatePickerData(totalYears: totalMonths + 1, toDate: fromDate, startDate: nil, endDate: endDate)
    }
    
    public func calculatePickerData(totalYears: Int, toDate: Date, startDate: Date?, endDate: Date?, isInitState: Bool = false) -> [CalendarPickerYear] {
        var calendarPickerYears = [CalendarPickerYear]()
        let staticCalendarPickerMonths = getStaticCalendarPickerMonths()
        
        for monthIndex in 0...totalYears {
            if
                let currentMonthDate = calendar.date(byAdding: .year, value: monthIndex, to: toDate)?.removeTimeStamp() {
                
                var yearTitle = currentMonthDate.dateToString(dateFormat: "yyyy", locale).capitalized
                if let numberYear = Int(yearTitle) {
                    yearTitle = "\(numberYear)"
                }
                
                if let startDate = startDate,
                   Calendar.current.startOfYear(currentMonthDate).removeTimeStamp() <= startDate.removeTimeStamp() {
                    let lastYearDate = Calendar.current.monthDate(by: 12, dayIndex: 16, date: currentMonthDate)
                    let toDate = Calendar.current.nextMonth(lastYearDate)
                    let totalMonths = calendar.dateComponents([.month],
                                                                 from: startDate,
                                                                 to: toDate).month
                    if let totalMonths = totalMonths, totalMonths >= 0 {
                        let localCalendarPickerMonths = getMounthsFromStart(
                            totalMonths: totalMonths,
                            toDate: currentMonthDate)
                        calendarPickerYears.append(CalendarPickerYear(
                                                    title: yearTitle,
                                                    months: localCalendarPickerMonths,
                                                    date: currentMonthDate))
                    }
                    
                } else if let endDate = endDate,
                          Calendar.current.endOfYear(currentMonthDate).removeTimeStamp() >= endDate {
                    
                    if let totalMonths = calendar.dateComponents([.month],
                                                                 from: Calendar.current.startOfYear(currentMonthDate).removeTimeStamp(),
                                                                 to: endDate).month, totalMonths > 0 {
                        let localCalendarPickerMonths = getMounthsFromEnd(
                            totalMonths: totalMonths,
                            toDate: Calendar.current.startOfYear(currentMonthDate).removeTimeStamp())
                        
                        calendarPickerYears.append(CalendarPickerYear(
                                                    title: yearTitle,
                                                    months: localCalendarPickerMonths,
                                                    date: currentMonthDate))
                    }
                    
                } else {
                    calendarPickerYears.append(CalendarPickerYear(
                                                title: yearTitle,
                                                months: staticCalendarPickerMonths,
                                                date: currentMonthDate))
                }
            }
        }
        
        return calendarPickerYears
    }
    
    public func calculateDates(startDate: Date, endDate: Date, monthDate: Date? = nil) -> ([Date],Date?) {
        var dates = [Date]()
        let currentDate = (monthDate ?? Date()).firstDateOfMonth().removeTimeStamp()
        
        guard let totalMonths = calendar.dateComponents([.month],
                                                  from: startDate,
                                                  to: endDate).month else {
            return (dates, nil)
        }
        
        for monthIndex in 0...totalMonths {
            if let currentMonthDate = calendar.date(byAdding: .month, value: monthIndex, to: startDate) {
                if let date = currentMonthDate.firstDateOfMonth()?.removeTimeStamp() {
                    dates.append(date)
                }
            }
        }
        
        return (dates, currentDate)
    }
    
    // MARK: - Private Methods
    
    private func getStaticCalendarPickerMonths() -> [CalendarPickerMonth] {
        var staticCalendarPickerMonths = [CalendarPickerMonth]()
        
        for index in months.indices {
            staticCalendarPickerMonths.append(CalendarPickerMonth(
                title: months[index].capitalized,
                index: index,
                year: "",
                date: Date()))
        }
        
        return staticCalendarPickerMonths
    }
    
    private func getMounthsFromStart(totalMonths: Int, toDate: Date) -> [CalendarPickerMonth] {
        var localCalendarPickerMonths = [CalendarPickerMonth]()
        
        for index in 0..<totalMonths {
            if
                let currentMonthDate = calendar.date(byAdding: .month, value: index, to: toDate)?.removeTimeStamp() {
                
                let monthTitle = currentMonthDate.dateToString(dateFormat: "LLLL", locale).capitalized
                let yearTitle = currentMonthDate.dateToString(dateFormat: "yyyy", locale).capitalized
                
                if let monthIndex = months.firstIndex(where: { $0.capitalized == monthTitle } ) {
                    localCalendarPickerMonths.append(CalendarPickerMonth(
                        title: monthTitle,
                        index: monthIndex,
                        year: yearTitle,
                        date: currentMonthDate))
                }
            }
        }
        
        return localCalendarPickerMonths
    }
    
    private func getMounthsFromEnd(totalMonths: Int, toDate: Date) -> [CalendarPickerMonth] {
        var localCalendarPickerMonths = [CalendarPickerMonth]()
        
        for index in 0...totalMonths {
            if
                let currentMonthDate = calendar.date(byAdding: .month,
                                                     value: index,
                                                     to: toDate)?.removeTimeStamp() {
                
                let monthTitle = currentMonthDate.dateToString(dateFormat: "LLLL", locale).capitalized
                let yearTitle = currentMonthDate.dateToString(dateFormat: "yyyy", locale).capitalized
                
                localCalendarPickerMonths.append(CalendarPickerMonth(
                                                title: monthTitle,
                                                index: index,
                                                year: yearTitle,
                                                date: currentMonthDate))
            }
        }
        
        return localCalendarPickerMonths
    }
    
    public func monthMetadata(for baseDate: Date) -> MonthMetadata? {
        guard
            let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
            let firstDayOfMonth = baseDate.firstDateOfMonth()
        else { return nil }
        
        var firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth) + 1 - calendar.firstWeekday
        if firstDayWeekday <= 0 {
            firstDayWeekday += 7
        }
        
        return MonthMetadata(numberOfDays: numberOfDaysInMonth,
                             firstDay: firstDayOfMonth,
                             firstDayWeekday: firstDayWeekday)
    }
    
    public func generateDaysInMonth(metadata: MonthMetadata) -> [CalendarDay] {
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        let totalDays = numberOfDaysInMonth + offsetInInitialRow
        var days: [CalendarDay] = []
        for i in 1..<totalDays {
            let isWithinDisplayedMonth = i >= offsetInInitialRow
            let dayOffset = isWithinDisplayedMonth ? i - offsetInInitialRow : -(offsetInInitialRow - i)
            let day = generateDay(offsetBy: dayOffset,
                                  for: firstDayOfMonth,
                                  isWithinDisplayedMonth: isWithinDisplayedMonth)
            days.append(day)
        }
 
        return days
    }
    
    private func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> CalendarDay {
        
        let date = calendar.date(byAdding: .day,
                                 value: dayOffset,
                                 to: baseDate)
            ?? baseDate
        
        let isCurrentDay = calendar.isDate(date, equalTo: Date(), toGranularity: .day)
        return CalendarDay(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: false,
            isCurrentDay: isCurrentDay,
            isDisplayedInMonth: isWithinDisplayedMonth
        )
    }
    
    private mutating func calculateMonth() {
        var month = 0
        for _ in 1...12 {
            months.append(dateFormatter.standaloneMonthSymbols[month].capitalized)
            month += 1
        }
    }
    
    private mutating func updateLocale() {
        calendar.locale = locale
        dateFormatter.locale = locale
    }
    
}
