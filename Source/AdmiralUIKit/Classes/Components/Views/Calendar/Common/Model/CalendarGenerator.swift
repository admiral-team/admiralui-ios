//
//  CalendarGenerator.swift
//  AdmiralUI
//
//  Created on 18.11.2020.
//

import Foundation

struct MonthMetadata {
    let numberOfDays: Int
    let firstDay: Date
    let firstDayWeekday: Int
}

enum CalendarDataError: Error {
    case metadataGeneration
}

protocol CalendarGeneratorDelegate: AnyObject {
    var locale: Locale? { get set }
    var currentMonthIndex: Int { get }
    var currentDayIndex: Int { get }
    func compareDate(firstDate: Date,
                     secondDate: Date,
                     with granularity: Calendar.Component,
                     byOrder order: ComparisonResult) -> Bool
    func calculateMonthsData(startDate: Date, endDate: Date) -> [Month]
    func calculatePreviousMonthData(currentDate: Date, startDate: Date) -> Date?
    func calculateNextMonthData(currentDate: Date, endDate: Date) -> Date?
}

class CalendarGenerator: CalendarGeneratorDelegate {
    
    // MARK: - Public Properties
    var locale: Locale? {
        didSet { updateLocale() }
    }
    var currentMonthIndex: Int = 0
    var currentDayIndex: Int = 0
    
    // MARK: - Private Properties
    
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
    
    // MARK: - Public Methods
    
    func compareDate(firstDate: Date,
                     secondDate: Date,
                     with granularity: Calendar.Component = .day,
                     byOrder order: ComparisonResult = .orderedSame) -> Bool {
        return calendar.compare(firstDate, to: secondDate, toGranularity: granularity) == order
    }
    
    func calculateMonthsData(startDate: Date, endDate: Date) -> [Month] {
        var months = [Month]()
        guard let totalMonths = calendar.dateComponents(
            [.month],
            from: startDate,
            to: endDate).month
        else { return months }
        
        for monthIndex in 0...totalMonths {
            if
                let currentMonthDate = calendar.date(byAdding: .month, value: monthIndex, to: startDate),
                let monthMetaData = monthMetadata(for: currentMonthDate) {
                let days = generateDaysInMonth(metadata: monthMetaData)
                let title = currentMonthDate.dateToString(dateFormat: "LLLL yyyy", locale: locale).capitalized
                if calendar.isDate(currentMonthDate, equalTo: Date(), toGranularity: .month) {
                    currentMonthIndex = monthIndex
                }
                
                let month = Month(days: days, title: title)
                months.append(month)
            }
        }
        
        return months
    }
    
    func calculatePreviousMonthData(currentDate: Date, startDate: Date) -> Date? {
        let preMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)
        let distantPast: Date = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            let date = formatter.date(from: "0001 01 01") !! fatalError("Invalid date")
            return date
        }()
        guard let preMonth = preMonth,
              preMonth > startDate,
              preMonth > distantPast else { return nil }
        return preMonth
    }
    
    func calculateNextMonthData(currentDate: Date, endDate: Date) -> Date? {
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? Date()
        let endFinalDate =  Calendar.current.nextMonth(endDate).startOfMonth().removeTimeStamp()
        guard nextMonthDate < endFinalDate else { return nil }
        return nextMonthDate
    }
    
    func monthMetadata(for baseDate: Date) -> MonthMetadata? {
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
    
    func generateDaysInMonth(metadata: MonthMetadata) -> [Day] {
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        let totalDays = numberOfDaysInMonth + offsetInInitialRow
        var days: [Day] = []
        for i in 1..<totalDays {
            let isWithinDisplayedMonth = i >= offsetInInitialRow
            let dayOffset = isWithinDisplayedMonth ? i - offsetInInitialRow : -(offsetInInitialRow - i)
            let day = generateDay(offsetBy: dayOffset,
                                  for: firstDayOfMonth,
                                  isWithinDisplayedMonth: isWithinDisplayedMonth)
            if day.isCurrentDay {
                currentDayIndex = i - 1
            }
            days.append(day)
        }
 
        return days
    }
    
    // MARK: - Private Methods
    
    private func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        
        let date = calendar.date(byAdding: .day,
                                 value: dayOffset,
                                 to: baseDate)
            ?? baseDate
        
        let isCurrentDay = calendar.isDate(date, equalTo: Date(), toGranularity: .day)
        return Day(date: date,
                   number: dateFormatter.string(from: date),
                   isSelected: false,
                   isCurrentDay: isCurrentDay,
                   isDisplayedInMonth: isWithinDisplayedMonth)
    }
    
    private func updateLocale() {
        calendar.locale = locale
        dateFormatter.locale = locale
    }
    
}
