//
//  CalendarDaysView.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct CalendarDaysView: View {

    // MARK: - Private Properties

    @Binding private var startDate: Date?
    @Binding private var endDate: Date?

    @State private var isMutlipleSelectionAllowed: Bool

    private var date: Date
    private var notActiveAfterDate: Date?
    private var pointDates: [Date]

    @Binding private var scheme: CalendarViewCellColorScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CalendarViewCellColorScheme>()

    // MARK: - Initializer

    public init(
        date: Date,
        isMutlipleSelectionAllowed: Bool,
        startDate: Binding<Date?>,
        endDate: Binding<Date?>,
        notActiveAfterDate: Date?,
        pointDates: [Date],
        scheme: Binding<CalendarViewCellColorScheme?> = .constant(nil)
    ) {
        self.date = date
        self._isMutlipleSelectionAllowed = .init(initialValue: isMutlipleSelectionAllowed)
        self._startDate = startDate
        self._endDate = endDate
        self.pointDates = pointDates.map( { $0.removeTimeStamp() })
        self.notActiveAfterDate = notActiveAfterDate
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let grid = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())]
        let generator = CalendarGenerator()
        var days = [CalendarDay]()
        if let monthMetadata = generator.monthMetadata(for: date) {
            days = generator.generateDaysInMonth(metadata: monthMetadata)
        }
        return LazyVGrid(columns: grid, spacing: LayoutGrid.halfModule * 5) {
            ForEach(0..<days.count, id: \.self) { index in
                dayView(day: days[index])
            }
        }
    }

    // MARK: - Priate Methods

    @ViewBuilder
    private func dayView(day: CalendarDay) -> some View {
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
    private func textView(day: CalendarDay) -> some View {
        if let notActiveAfterDate = notActiveAfterDate.removeTimeStamp(), notActiveAfterDate < day.date, day.isDisplayedInMonth {
            inactiveTextView(day: day)
        } else if checkSelect(date: day.date), day.isDisplayedInMonth {
            selectedTextView(day: day)
        } else if day.isCurrentDay, day.isDisplayedInMonth {
            currentTextView(day: day)
        } else {
            basicTextView(day: day)
        }
    }

    private func checkSelect(date: Date) -> Bool {

        let startDate = startDate?.removeTimeStamp()
        let endDate = endDate?.removeTimeStamp()

        if let startDate = startDate, startDate <= date {
            if startDate == date {
                return true
            } else if let endDate = endDate, endDate >= date {
                return true
            }
        }
        return false
    }

    private func selectedTextView(day: CalendarDay) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let startDate = startDate.removeTimeStamp()
        let endDate = endDate.removeTimeStamp()

        if day.date == startDate || day.date == endDate {
            let date = day.date.copyDate()
            let backgroundColor = scheme.selectedBackgroundColors.parameter(for: .tailSelected)?.swiftUIColor
            return backgroundColor?
                .cornerRadius(LayoutGrid.halfModule)
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                .overlay(
                    Text(day.isDisplayedInMonth  ? day.number : "")
                        .font(scheme.titleLabelFont.swiftUIFont)
                        .foregroundColor(scheme.textColors.parameter(for: .tailSelected)?.swiftUIColor)
                        .onTapGesture {
                            tapDate(date)
                        })
                .eraseToAnyView()

        } else {
            let date = day.date.copyDate()
            let backgroundColor = scheme.selectedBackgroundColors.parameter(for: .selected)?.swiftUIColor
            return backgroundColor?
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                .cornerRadius(LayoutGrid.halfModule)
                .overlay(
                    Text(day.isDisplayedInMonth  ? day.number : "")
                        .font(scheme.titleLabelFont.swiftUIFont)
                        .foregroundColor(scheme.textColors.parameter(for: .selected)?.swiftUIColor)
                        .onTapGesture {
                            tapDate(date)
                        }
                )
                .eraseToAnyView()
        }
    }

    private func currentTextView(day: CalendarDay) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let date = day.date.copyDate()
        return Button(action: {
            tapDate(date)
        }) {
            Text(day.isDisplayedInMonth  ? day.number : "")
            .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            .font(scheme.titleLabelFont.swiftUIFont)
            .foregroundColor(scheme.textColors.parameter(for: .currentDate)?.swiftUIColor)
            .overlay(
                RoundedRectangle(cornerRadius: LayoutGrid.halfModule)
                    .stroke(scheme.borderColors.parameter(for: .currentDate)?.swiftUIColor ?? .clear, lineWidth: 2)
            )
        }
    }

    private func inactiveTextView(day: CalendarDay) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return Text(day.isDisplayedInMonth ? day.number : "")
            .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            .font(scheme.titleLabelFont.swiftUIFont)
            .foregroundColor(scheme.textColors.parameter(for: .inactive)?.swiftUIColor)
            .eraseToAnyView()
    }

    private func basicTextView(day: CalendarDay) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let date = day.date.copyDate()
        if day.isDisplayedInMonth {
            return Button(action: {
                tapDate(date)
            }) {
                Text(day.isDisplayedInMonth ? day.number : "")
                    .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                    .font(scheme.titleLabelFont.swiftUIFont)
                    .foregroundColor(scheme.textColors.parameter(for: .normal)?.swiftUIColor)
            }
            .eraseToAnyView()
        } else {
            return Text(day.isDisplayedInMonth ? day.number : "")
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                .font(scheme.titleLabelFont.swiftUIFont)
                .foregroundColor(scheme.textColors.parameter(for: .normal)?.swiftUIColor)
                .eraseToAnyView()
        }
    }

    private func tapDate(_ date: Date) {
        isMutlipleSelectionAllowed ? prepareMultipleSelectionDates(date: date) : prepareSingleSelectionDate(date: date)
    }

    private func prepareMultipleSelectionDates(date: Date) {
        if let startDate = startDate,
            let endDate = endDate,
            startDate <= date, endDate >= date {
            self.startDate = date
            self.endDate = nil
            return
        }

        if let startDate = startDate,
            let _ = endDate {
            if startDate > date {
                self.startDate = date
            } else {
                self.endDate = date
            }
            return
        } else if let startDate = startDate {
            if startDate > date {
                self.endDate = startDate
                self.startDate = date
            } else {
                self.endDate = date
            }
        } else {
            self.startDate = date
        }
    }

    private func prepareSingleSelectionDate(date: Date) {
        if let startDate = startDate,
           startDate == date {
            self.startDate = nil
        } else {
            startDate = date
        }
    }

}
