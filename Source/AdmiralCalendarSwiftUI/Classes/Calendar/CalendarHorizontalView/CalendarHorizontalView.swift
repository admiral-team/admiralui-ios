//
//  NewCalendarView.swift
//  AdmiralSwiftUI
//
//  Created on 09.09.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct CalendarHorizontalView: View {

    enum CalendarHorizontalViewDirection {
        case forward
        case back
        case none
    }

    // MARK: - Constants

    enum Constants {
        static let calendarHeight: CGFloat = 376.0
        static let calendarHorizontalViewHeight: CGFloat = 356.0
        static let pickerViewHeight: CGFloat = 215.0
        static let monthFormat = "LLLL"
        static let yearFormat = "yyyy"
        static let dateBuffer: Int = 50
    }

    // MARK: - Internal Properties

    /// The start date of calendar.
    var startDate: Date?

    /// The end date of calendar.
    var endDate: Date?

    /// Calendar loclole
    var locale: Locale?

    /// Selected start date of calendar.
    @Binding var selectedStartDate: Date?

    /// Selected end date of calendar.
    @Binding var selectedEndDate: Date?

    /// The date of moth and year.
    var monthYearDate: Date?

    /// Not active after date.
    var notActiveAfterDate: Date?

    /// The state selection.
    var isMutlipleSelectionAllowed: Bool = true

    /// Dates with a dot at the bottom.
    let pointDates: [Date]

    /// Selected dates.
    let selectedDates: [Date]

    /// Spacing between rows of days.
    let spacingBetweenRows: CGFloat

    // MARK: - Private Properties

    @State private var currentTouchOffset: CGFloat?

    @State private var isHeaderOpen: Bool = true

    @State private var currentDate: Date

    @State private var opacityBackElement: Double = 0.0
    @State private var opacityCurrentElement: Double = 1.0
    @State private var opacityNextElement: Double = 0.0

    @State private var direction: CalendarHorizontalViewDirection = .none

    @State private var selectionMonth: Int = 0
    @State private var selectionYear: Int = 0
    @State private var pickerSelections: [Int] = [0, 0]

    @ObservedObject var schemeProvider: SchemeProvider<CalendarHorizontalViewScheme>

    @State private var calendarPickerYears = [CalendarPickerYear]()

    // MARK: - Initializer

    public init(
        startDate: Date? = nil,
        endDate: Date? = nil,
        locale: Locale? = nil,
        selectedStartDate: Binding<Date?>,
        selectedEndDate: Binding<Date?>,
        monthYearDate: Date? = nil,
        notActiveAfterDate: Date?,
        isMutlipleSelectionAllowed: Bool = true,
        pointDates: [Date],
        selectedDates: [Date],
        spacingBetweenRows: CGFloat = LayoutGrid.halfModule * 5,
        schemeProvider: SchemeProvider<CalendarHorizontalViewScheme> = AppThemeSchemeProvider<CalendarHorizontalViewScheme>()
    ) {
        self.startDate = startDate
        self.endDate = endDate

        self.locale = locale
        self.pointDates = pointDates
        self.selectedDates = selectedDates
        self.spacingBetweenRows = spacingBetweenRows

        self._currentDate = .init(initialValue: monthYearDate ?? Date())

        self.isMutlipleSelectionAllowed = isMutlipleSelectionAllowed
        self._selectedStartDate = selectedStartDate
        self._selectedEndDate = selectedEndDate
        self.monthYearDate = monthYearDate.removeTimeStamp()
        self.notActiveAfterDate = notActiveAfterDate
        self.schemeProvider = schemeProvider

        let preInitDates = preInitDate()
        var generator = CalendarGenerator()
        generator.locale = locale
        if let pickerData = generator.calculateInitPickerData(
            startInitDate: preInitDates.0,
            endInitDate: preInitDates.1,
            startDate: self.startDate,
            endDate: self.endDate) {
            self._calendarPickerYears = .init(initialValue: pickerData)
        }
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        var title = ""

        if isHeaderOpen {
            title = headerTitle()
        } else {
            if calendarPickerYears.count > selectionYear {
                let selectionMonth = calendarPickerYears[selectionYear].months.count > selectionMonth ? selectionMonth : 0
                let month = calendarPickerYears[selectionYear].months[selectionMonth].title
                var year = calendarPickerYears[selectionYear].title
                if let number = Int(year) {
                    year = "\(number)"
                }
                title = "\(month) \(year)"
            }
        }

        let isShowMonth = true
        return VStack(alignment: .leading, spacing: 0) {
            if isShowMonth {
                CalendarHorizontalHeaderView(
                    title: title,
                    isOpen: $isHeaderOpen,
                    monthYearButtonTap: {
                        let yearTitle = currentDate.dateToString(dateFormat: Constants.yearFormat, locale).capitalized
                        let monthTitle = currentDate.dateToString(dateFormat: Constants.monthFormat, locale).capitalized
                        if isHeaderOpen,
                           let yearIndex = calendarPickerYears.firstIndex(where: { $0.title == yearTitle }),
                           let monthIndex = calendarPickerYears[yearIndex].months.firstIndex(where: { $0.title == monthTitle })  {
                            selectionYear = yearIndex
                            selectionMonth = monthIndex
                            pickerSelections = [selectionMonth, selectionYear]
                        } else {
                            changeCurrentDateAfterPicker()
                        }

                        withAnimation(.easeIn(duration: 0.5)) {
                            isHeaderOpen.toggle()
                        }
                    }, leftArrowTap: {
                        let generator = CalendarGenerator()
                        let preMonthDate = generator.calculatePreviousMonthData(currentDate: currentDate, startDate: startDate)
                        if preMonthDate != nil {
                            withAnimation(.linear(duration: 0.5)) {
                                direction = .back
                                opacityCurrentElement = 0.0
                                opacityBackElement = 1.0
                            }
                        }
                    }, rightArrowTap: {
                        let generator = CalendarGenerator()
                        let nextMonthdate = generator.calculateNextMonthData(currentDate: currentDate, endDate: endDate)
                        if nextMonthdate != nil {
                            withAnimation(.linear(duration: 0.5)) {
                                direction = .forward
                                opacityCurrentElement = 0.0
                                opacityNextElement = 1.0
                            }
                        }
                    }, choiceTap: {
                        changeCurrentDateAfterPicker()
                        withAnimation(.easeIn(duration: 0.5)) {
                            isHeaderOpen.toggle()
                        }
                    },
                    schemeProvider: SchemeProvider.constant(scheme: scheme.headerViewScheme)
                )
                .animation(nil)
                .frame(height: LayoutGrid.quadrupleModule)

                if isHeaderOpen {
                    CalendarWeekView(
                        locale,
                        schemeProvider: SchemeProvider.constant(scheme: scheme.calendarWeekViewScheme)
                    )
                        .frame(height: LayoutGrid.halfModule * 9)
                    Spacer()
                        .frame(height: LayoutGrid.halfModule * 5)
                } else {
                    Spacer()
                        .frame(height: LayoutGrid.halfModule * 14)
                }
                ZStack {
                    if isHeaderOpen {
                        monthViews()
                            .opacity(isHeaderOpen ? 1.0 : 0.0)
                            .frame(height: Constants.calendarHorizontalViewHeight)
                    } else {
                        pickerViews()
                            .offset(y: -LayoutGrid.quadrupleModule)
                            .opacity(isHeaderOpen ? 0.0 : 1.0)
                            .frame(height: Constants.calendarHorizontalViewHeight)
                    }
                }
            }
        }
        .frame(height: Constants.calendarHeight)
    }

    // MARK: - Private Methods

    private func changeCurrentDateAfterPicker() {
        if calendarPickerYears.count > selectionYear {
            let monthIndex = calendarPickerYears[selectionYear].months.count > selectionMonth
            ? calendarPickerYears[selectionYear].months[selectionMonth].index : (calendarPickerYears[selectionYear].months.last?.index ?? 0)
            let pickerDate = Calendar.current.monthDate(
                by: monthIndex + 1,
                dayIndex: 16,
                date: calendarPickerYears[selectionYear].date).removeTimeStamp()
            currentDate = pickerDate
        }
    }

    private func pickerViews() -> some View {
        let scheme = schemeProvider.scheme

        var data = [[String]]()
        let months = calendarPickerYears[selectionYear].months.map({ $0.title })
        let years = calendarPickerYears.map({ $0.title })
        data.append(months)
        data.append(years)

        return GeometryReader { geometry in
            UIKitPickerView(data: data, selections: $pickerSelections, textColor: scheme.pickerTitleColor.uiColor, widthPicker: geometry.size.width)
                .onChange(of: pickerSelections) { value in
                    self.selectionMonth = value[0]
                    self.selectionYear = value[1]
                    appendingPickerData(value: value[1])
                }
        }
    }

    private func appendingPickerData(value: Int) {
        guard !calendarPickerYears.isEmpty else { return }

        let rangeFromStart = 0...Constants.dateBuffer
        let rangeFromEnd = (calendarPickerYears.count - Constants.dateBuffer)...(calendarPickerYears.count - 1)
        let generator = CalendarGenerator()

        if rangeFromStart.contains(value) {
            if let pickerStartDate = calendarPickerYears.first?.date,
               let indexFirstMonth = calendarPickerYears.first?.months.first?.index,
               let calendarPickerData = generator.calculateStartPickerData(
                startDate: startDate,
                pickerStartDate: Calendar.current.monthDate(by: indexFirstMonth, dayIndex: 16, date: pickerStartDate)) {
                calendarPickerYears.insert(contentsOf: calendarPickerData, at: 0)
                selectionYear = calendarPickerData.count + value
                pickerSelections = [selectionMonth, selectionYear]
            }
        }
        if rangeFromEnd.contains(value) {

            if let pickerEndDate = calendarPickerYears.last?.date,
               let indexLastMonth = calendarPickerYears.last?.months.last?.index,
               let calendarPickerData = generator.calculateEndPickerData(
                endDate: endDate,
                pickerEndDate:  Calendar.current.monthDate(by: indexLastMonth + 1, dayIndex: 16, date: pickerEndDate)) {
                calendarPickerYears.append(contentsOf: calendarPickerData)
            }
        }
    }

    private func preInitDate() -> (Date, Date) {
        guard let startDate = startDate, let endDate = endDate else {
            if let startDate = startDate {
                return preDates(startDate: startDate, endDate: Date.distantFuture)
            } else if let endDate = endDate {
                return preDates(startDate: Date.distantPast, endDate: endDate)
            }
            return preDates(startDate: Date.distantPast, endDate: Date.distantFuture)
        }

        return preDates(startDate: startDate, endDate: endDate)
    }

    private func headerTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.monthFormat
        formatter.locale = locale

        let month = formatter.string(from: currentDate).capitalized

        formatter.dateFormat = Constants.yearFormat
        var year = formatter.string(from: currentDate).capitalized
        if let number = Int(year) {
            year = "\(number)"
        }
        return "\(month) \(year)"
    }

    private func preDates(startDate: Date, endDate: Date) -> (Date, Date) {
        var preStartDate = Date()
        var preEndDate = Date()

        if let monthYearDate = monthYearDate {
            if startDate < monthYearDate,  monthYearDate < endDate {
                if let calendarStartDate = Calendar.current.date(byAdding: .year, value: -100, to: monthYearDate),
                   startDate < calendarStartDate {
                    preStartDate = Calendar.current.startOfYear(calendarStartDate)
                } else {
                    preStartDate = startDate
                }

                if let calendarEndDate = Calendar.current.date(byAdding: .year, value: 100, to: monthYearDate),
                    endDate > calendarEndDate {
                    preEndDate = Calendar.current.endOfYear(calendarEndDate)
                } else {
                    preEndDate = endDate
                }
            } else {
                if let calendarStartDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()),
                   startDate < calendarStartDate {
                    preStartDate = Calendar.current.startOfYear(calendarStartDate)
                } else {
                    preStartDate = startDate
                }

                if let calendarEndDate = Calendar.current.date(byAdding: .year, value: 100, to: Date()),
                    endDate > calendarEndDate {
                    preEndDate = Calendar.current.endOfYear(calendarEndDate)
                } else {
                    preEndDate = endDate
                }
            }
        } else if startDate < Date(),  Date() < endDate {
            if let calendarStartDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()),
               startDate < calendarStartDate {
                preStartDate = Calendar.current.startOfYear(calendarStartDate)
            } else {
                preStartDate = startDate
            }

            if let calendarEndDate = Calendar.current.date(byAdding: .year, value: 100, to: Date()), endDate > calendarEndDate {
                preEndDate = Calendar.current.endOfYear(calendarEndDate)
            } else {
                preEndDate = endDate
            }
        } else {
            preStartDate = endDate
            preEndDate = endDate
        }

        return (preStartDate, preEndDate)
    }

    private func backViewOffset(width: CGFloat, direction: CalendarHorizontalViewDirection) -> CGFloat {
        guard let currentTouchOffset = currentTouchOffset, direction == .none else {
            switch direction {
            case .back:
                return 0.0
            case .forward:
                return 0.0
            case .none:
                return -width
            }
        }

        return -width + currentTouchOffset
    }

    private func currentViewOffset(width: CGFloat, direction: CalendarHorizontalViewDirection) -> CGFloat {
        guard let currentTouchOffset = currentTouchOffset, direction == .none else {
            switch direction {
            case .back:
                return width
            case .forward:
                return -width
            case .none:
                return 0.0
            }
        }
        return currentTouchOffset
    }

    private func nextViewOffset(width: CGFloat, direction: CalendarHorizontalViewDirection) -> CGFloat {
        guard let currentTouchOffset = currentTouchOffset, direction == .none else {
            switch direction {
            case .back:
                return 0.0
            case .forward:
                return 0.0
            case .none:
                return width
            }
        }
        return width + currentTouchOffset
    }

    private func monthViews() -> some View {
        let scheme = schemeProvider.scheme
        let generator = CalendarGenerator()
        let preMonthDate = generator.calculatePreviousMonthData(currentDate: currentDate, startDate: startDate)
        let nextMonthdate = generator.calculateNextMonthData(currentDate: currentDate, endDate: endDate)

        return GeometryReader { geometry in
            ZStack(alignment: .top) {
                if let preMonthDate = preMonthDate {
                    CalendarDaysView(
                        date: Date(timeInterval: 0, since: preMonthDate),
                        isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                        startDate: $selectedStartDate,
                        endDate: $selectedEndDate,
                        notActiveAfterDate: notActiveAfterDate,
                        pointDates: pointDates,
                        selectedDays: selectedDates,
                        spacingBetweenRows: spacingBetweenRows,
                        schemeProvider: SchemeProvider.constant(scheme: scheme.calendarViewCellColorScheme)
                    )
                        .frame(height: Constants.calendarHorizontalViewHeight, alignment: .top)
                        .offset(x: backViewOffset(
                                    width: geometry.size.width,
                                    direction: direction))
                        .opacity(opacityBackElement)
                        .onAnimationCompleted(for: opacityBackElement) {
                            opacityCurrentElement = 0.0
                            direction = .none
                            opacityBackElement = 0.0
                            currentDate = preMonthDate.removeTimeStamp()
                            opacityCurrentElement = 1.0
                            currentTouchOffset = nil
                        }
                }
                CalendarDaysView(
                    date: Date(timeInterval: 0, since: currentDate),
                    isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                    startDate: $selectedStartDate,
                    endDate: $selectedEndDate,
                    notActiveAfterDate: notActiveAfterDate,
                    pointDates: pointDates,
                    selectedDays: selectedDates,
                    spacingBetweenRows: spacingBetweenRows,
                    schemeProvider: SchemeProvider.constant(scheme: scheme.calendarViewCellColorScheme)
                )
                    .frame(height: Constants.calendarHorizontalViewHeight, alignment: .top)
                    .offset(x: currentViewOffset(
                                width: geometry.size.width,
                                direction: direction))
                    .opacity(opacityCurrentElement)
                if let nextMonthdate = nextMonthdate {
                    CalendarDaysView(
                        date: Date(timeInterval: 0, since: nextMonthdate),
                        isMutlipleSelectionAllowed: isMutlipleSelectionAllowed,
                        startDate: $selectedStartDate,
                        endDate: $selectedEndDate,
                        notActiveAfterDate: notActiveAfterDate,
                        pointDates: pointDates,
                        selectedDays: selectedDates,
                        spacingBetweenRows: spacingBetweenRows,
                        schemeProvider: SchemeProvider.constant(scheme: scheme.calendarViewCellColorScheme)
                    )
                        .frame(height: Constants.calendarHorizontalViewHeight, alignment: .top)
                        .offset(x: nextViewOffset(
                                    width: geometry.size.width,
                                    direction: direction))
                        .opacity(opacityNextElement)
                        .onAnimationCompleted(for: opacityNextElement) {
                            opacityCurrentElement = 0.0
                            direction = .none
                            opacityNextElement = 0.0
                            currentDate = nextMonthdate.removeTimeStamp()
                            opacityCurrentElement = 1.0
                            currentTouchOffset = nil
                        }
                }
            }
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                currentTouchOffset = value.translation.width
                if value.translation.width > 0 {
                    changedOpacityAfterSwipeRight(offset: value.translation.width, width: geometry.size.width)
                } else {
                    changedOpacityAfterSwipeLeft(offset: value.translation.width, width: geometry.size.width)
                }
            }).onEnded({ value in
                guard abs(value.translation.width) > 48.0 else {
                    scrollToCurrent()
                    return
                }

                if value.translation.width < 0 {
                    let nextMonthdate = generator.calculateNextMonthData(currentDate: currentDate, endDate: endDate)
                    if nextMonthdate != nil {
                        finishSwipeRight()
                    } else {
                        scrollToCurrent()
                    }
                } else if value.translation.width > 0 {
                    let preMonthDate = generator.calculatePreviousMonthData(currentDate: currentDate, startDate: startDate)
                    if preMonthDate != nil {
                        finishSwipeLeft()
                    } else {
                        scrollToCurrent()
                    }
                }
            }))
        }
        .frame(height: Constants.calendarHorizontalViewHeight)
    }

    private func scrollToCurrent() {
        withAnimation(.linear(duration: Durations.Default.double)) {
            currentTouchOffset = 0
            opacityCurrentElement = 1
        }
    }

    private func changedOpacityAfterSwipeRight(offset: CGFloat, width: CGFloat) {
        self.opacityNextElement = 0
        self.opacityCurrentElement = Double(opacityCurrentElement(offset: offset, width: width))
        self.opacityBackElement =  Double(opacityChangedElement(offset: offset, width: width))
    }

    private func changedOpacityAfterSwipeLeft(offset: CGFloat, width: CGFloat) {
        self.opacityBackElement = 0
        self.opacityCurrentElement = Double(opacityCurrentElement(offset: offset, width: width))
        self.opacityNextElement = Double(opacityChangedElement(offset: offset, width: width))
    }

    private func finishSwipeRight() {
        self.opacityBackElement = 0
        withAnimation(.linear(duration: 0.5)) {
            self.direction = .forward
            self.opacityNextElement = 1
            self.opacityCurrentElement = 0
        }
    }

    private func finishSwipeLeft() {
        self.opacityNextElement = 0
        withAnimation(.linear(duration: 0.5)) {
            self.direction = .back
            self.opacityBackElement = 1
            self.opacityCurrentElement = 0
        }
    }

    private func opacityCurrentElement(offset: CGFloat, width: CGFloat) -> CGFloat {
        return 1 - abs(offset) / width
    }

    private func opacityChangedElement(offset: CGFloat, width: CGFloat) -> CGFloat {
        return abs(offset) / width
    }

}
