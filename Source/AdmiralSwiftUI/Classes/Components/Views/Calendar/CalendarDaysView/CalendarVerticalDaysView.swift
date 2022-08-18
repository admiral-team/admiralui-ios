//
//  CalendarVerticalDaysView.swift
//  AdmiralSwiftUI
//
//  Created on 13.09.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct CalendarVerticalDaysView: View {

    // MARK: - Private Properties

    @Binding private var days: [Day]
    @Binding private var startDate: Date?
    @Binding private var endDate: Date?
    @Binding private var updateBlock: (Day) -> ()
    private var notActiveAfterDate: Date?
    private var pointDates: [Date]

    @State private var scheme: CalendarViewCellColorScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CalendarViewCellColorScheme>()
    
    // MARK: - Initializer
    
    public init(
        days: [Day],
        startDate: Date?,
        endDate: Date?,
        notActiveAfterDate: Date?,
        pointDates: [Date],
        updateBlock: @escaping (Day) -> (),
        scheme: CalendarViewCellColorScheme? = nil
    ) {
        self._days = Binding(
            get: { days },
            set: { _, _ in  }
        )
        self._startDate = Binding(
            get: { startDate },
            set: { _, _ in  }
        )
        self._endDate = Binding(
            get: { endDate },
            set: { _, _ in  }
        )
        self._updateBlock = Binding(
            get: { updateBlock },
            set: { _, _ in  }
        )
        self.pointDates = pointDates.map( { $0.removeTimeStamp() })
        self.notActiveAfterDate = notActiveAfterDate
        self.scheme = scheme
    }

    // MARK: - Body
    
    public var body: some View {
        let weekDays: [[Day]] = weeks()
        return VStack(spacing: LayoutGrid.halfModule * 5) {
            ForEach(weekDays, id: \.self) { week in
                HStack(spacing: 0.0) {
                    ForEach(0..<week.count, id: \.self) { index in
                        dayView(day: week[index])
                        if index != week.count - 1 {
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    // MARK: - Priate Methods
    
    @ViewBuilder
    private func dayView(day: Day) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(spacing: LayoutGrid.halfModule) {
            textView(day: day)
            if Set(pointDates).contains(day.date), day.isDisplayedInMonth {
                Circle()
                    .foregroundColor(scheme.dayPointColor.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule, height: LayoutGrid.halfModule)
            } else {
                Spacer()
                    .frame(width: LayoutGrid.halfModule, height: LayoutGrid.halfModule)
            }
        }
    }
    
    @ViewBuilder
    private func textView(day: Day) -> some View {
        if checkInactive(incativeDate: notActiveAfterDate, day: day) {
            inactiveTextView(day: day)
        } else if let startDate = startDate,
           let endDate = endDate,
                  day.date >= startDate,
                  day.date <= endDate,
                  day.isDisplayedInMonth {
            selectedTextView(day: day)
        } else if let startDate = startDate,
                  day.date == startDate,
                  day.isDisplayedInMonth {
            selectedTextView(day: day)
        } else if day.isCurrentDay, day.isDisplayedInMonth {
            currentTextView(day: day)
        } else {
            basicTextView(day: day)
        }
    }
    
    private func checkInactive(incativeDate: Date?, day: Day) -> Bool {
        if let notActiveAfterDate = incativeDate.removeTimeStamp(), notActiveAfterDate < day.date.removeTimeStamp(), day.isDisplayedInMonth {
            return true
        }
        return false
    }
    
    private func selectedTextView(day: Day) -> some View {
        let style = self.scheme ?? schemeProvider.scheme
        if day.date == startDate || day.date == endDate {
            return Text(day.isDisplayedInMonth  ? day.number : "")
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                .font(style.titleLabelFont.swiftUIFont)
                .background(style.selectedBackgroundColors.parameter(for: .tailSelected)?.swiftUIColor)
                .cornerRadius(LayoutGrid.halfModule)
                .foregroundColor(style.textColors.parameter(for: .tailSelected)?.swiftUIColor)
                .onTapGesture {
                    tapDay(day)
                }
        } else {
            return Text(day.isDisplayedInMonth  ? day.number : "")
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                .font(style.titleLabelFont.swiftUIFont)
                .background(style.selectedBackgroundColors.parameter(for: .selected)?.swiftUIColor)
                .cornerRadius(LayoutGrid.halfModule)
                .foregroundColor(style.textColors.parameter(for: .selected)?.swiftUIColor)
                .onTapGesture {
                    tapDay(day)
                }
        }
    }
    
    private func currentTextView(day: Day) -> some View {
        let style = self.scheme ?? schemeProvider.scheme
        return Text(day.isDisplayedInMonth  ? day.number : "")
            .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            .font(style.titleLabelFont.swiftUIFont)
            .background(style.backgroundColors.parameter(for: .currentDate)?.swiftUIColor)
            .foregroundColor(style.textColors.parameter(for: .currentDate)?.swiftUIColor)
            .onTapGesture {
                tapDay(day)
            }.overlay(
                RoundedRectangle(cornerRadius: LayoutGrid.halfModule)
                    .stroke(style.borderColors.parameter(for: .currentDate)?.swiftUIColor ?? .clear, lineWidth: 2)
            )
    }
    
    private func inactiveTextView(day: Day) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return Text(day.isDisplayedInMonth ? day.number : "")
            .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            .font(scheme.titleLabelFont.swiftUIFont)
            .foregroundColor(scheme.textColors.parameter(for: .inactive)?.swiftUIColor)
            .eraseToAnyView()
    }
    
    private func basicTextView(day: Day) -> some View {
        let style = self.scheme ?? schemeProvider.scheme
        return Text(day.isDisplayedInMonth ? day.number : "")
            .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            .font(style.titleLabelFont.swiftUIFont)
            .background(style.backgroundColors.parameter(for: .normal)?.swiftUIColor)
            .foregroundColor(style.textColors.parameter(for: .normal)?.swiftUIColor)
            .onTapGesture {
                guard day.isDisplayedInMonth else { return }
                tapDay(day)
            }
    }
    
    private func weeks() -> [[Day]] {
        var weekDays: [[Day]] = []
        var startIndex = 0
        var endIndex = 6
        let max = (Double(self.days.count) / 7).rounded(.up)
        
        for _ in 0..<Int(max) {
            let offset = startIndex...min(endIndex, self.days.count - 1)
            var days = Array(self.days[offset])
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
            weekDays.append(days)
            startIndex += 7
            endIndex += 7
        }
        return weekDays
    }
    
    private func tapDay(_ day: Day) {
        self.updateBlock(day)
    }
    
}

