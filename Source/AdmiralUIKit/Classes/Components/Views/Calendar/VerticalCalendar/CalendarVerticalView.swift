//
//  CalendarView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// CalendarViews delegate
@objc public protocol CalendarDelegate: AnyObject {
    
    /**
     Tells the delegate that the date at the specified index path was selected.
     
     - Parameter date:      The date of the cell that was selected.
     - Parameter indexPath: The index path of the cell that was selected.
     */
    @objc optional func didSelectDates(dates: [Date], itemAt indexPath: IndexPath)
    
    /**
     Tells the delegate that the date at the specified index path was selected.
     
     - Parameter date:      The date of the cell that was selected.
     - Parameter indexPath: The index path of the cell that was selected.
     */
    @objc optional func didDeselectDates(dates: [Date], forItemAt indexPath: IndexPath)
    /**
     Tells the delegate that the date at the specified index path will be selected.
     
     - Parameter calendar:    The current Сalendar instance.
     - Parameter date:      The date of the cell that was selected.
     - Parameter indexPath: The index path of the cell that was selected.
     */
    @objc optional func shouldSelectDate(date: Date, itemAt indexPath: IndexPath) -> Bool
    
    /**
     Tells the delegate that the date at the specified index path will be deselected.
     
     - Parameter calendar:    The current Сalendar instance.
     - Parameter date:      The date of the cell that was selected.
     - Parameter indexPath: The index path of the cell that was selected.
     */
    @objc optional func shouldDeselectDate(date: Date, forItemAt indexPath: IndexPath) -> Bool
    
    /**
     Tells the delegate that the month on horizontal calendar did change.
     
     - Parameter date: The current date on calendar.
     */
    @objc optional func didChangeMonthDate(date: Date)
    
}

/// CalendarViews dataSource
public protocol CalendarDataSource: AnyObject {
    /// The start date of calendar.
    var startDate: Date { get }
    /// The end date of calendar
    var endDate: Date { get }
}

public extension CalendarDataSource {
    
    var startDate: Date {
        return Date.distantPast
    }
    
    var endDate: Date {
        return Date.distantFuture
    }
    
}

class CalendarVerticalView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    /// The calendar delegate.
    weak var calendarDelegate: CalendarDelegate?
    weak var calendarDataSource: CalendarDataSource?
    
    /// The font of title
    var isMutlipleSelectionAllowed: Bool = true
    
    /// Select start date.
    var selectedStartDate: Date?
    
    /// Select end date.
    var selectedEndDate: Date?
    
    /// Not active after date.
    var notActiveAfterDate: Date?
    
    var pointDates: [Date] = [] {
        didSet { collectionView.reloadData() }
    }
    
    var scheme = CalendarVerticalViewScheme() {
        didSet { configure() }
    }
    
    var locale: Locale? {
        didSet { updateLocale() }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            CalendarDayCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(
            CalendarHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.headerIdentifier)
        collectionView.register(
            CalendarFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Constants.footerIdentifier)
        return collectionView
    }()
    
    private var selectedDates = [Date]()
    private var months: [Month] = [] {
        didSet { collectionView.reloadData() }
    }
    private var calendarGenerator: CalendarGeneratorDelegate?
    private enum Constants {
        static let cellIdentifier: String = "cell"
        static let headerIdentifier: String = "header"
        static let footerIdentifier: String = "footer"
    }
    
    // MARK: - Initiliazers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        guard let calendarGenerator = calendarGenerator else { return }
        
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(
                                        item: calendarGenerator.currentDayIndex,
                                        section: calendarGenerator.currentMonthIndex),
                                    at: .centeredVertically, animated: false)
    }
    
    // MARK: - Private Methods
    
    func reloadData() {
        guard
            let calendarGenerator = calendarGenerator,
            let startDate = calendarDataSource?.startDate,
            let endDate = calendarDataSource?.endDate
        else { return }
        
        months = calendarGenerator.calculateMonthsData(startDate: startDate, endDate: endDate)
    }
    
    func setStartSelectedDate(_ date: Date?) {
        guard let date = date else {
            if let selectedEndDate = selectedEndDate {
                prepareSelectedDates(date: selectedEndDate)
            } else {
                selectedDates.removeAll()
                collectionView.reloadData()
            }
            return
        }
        
        prepareSelectedDates(date: date)
    }
    
    func setEndSelectedDate(_ date: Date?) {
        guard let date = date else {
            selectedEndDate = nil
            collectionView.reloadData()
            return
        }
        
        prepareSelectedDates(date: date)
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CalendarVerticalViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        calendarGenerator = CalendarGenerator()
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
        NSLayoutConstraint.activate(fillView(view: collectionView))
    }
    
    private func prepareSelectedDates(date: Date) {
        isMutlipleSelectionAllowed ? prepareMultipleSelectionDates(date: date) : prepareSingleSelectionDate(date: date)
        collectionView.reloadData()
    }
    
    private func prepareMultipleSelectionDates(date: Date) {
        if selectedDates.contains(date) {
            selectedStartDate = date
            selectedEndDate = nil
            selectedDates.removeAll()
            selectedDates.append(date)
            return
        }
        
        if let startDate = selectedStartDate,
            let endDate = selectedEndDate {
            
            if startDate > date {
                selectedStartDate = date
                selectedDates = datesRange(from: date, to: endDate)
            } else {
                selectedEndDate = date
                selectedDates = datesRange(from: startDate, to: date)
            }
            return
        } else if let startDate = selectedStartDate {
            
            if startDate > date {
                selectedEndDate = selectedStartDate
                selectedStartDate = date
                selectedDates = datesRange(
                    from: selectedStartDate !! fatalError("No selected start date"),
                    to: selectedEndDate  !! fatalError("No selected end date")
                )
            } else {
                selectedEndDate = date
                selectedDates = datesRange(from: startDate, to: date)
            }
        } else {
            selectedStartDate = date
            selectedDates.append(date)
        }
    }
    
    private func prepareSingleSelectionDate(date: Date) {
        selectedDates.removeAll()
        if
            let selectedStartDate = selectedStartDate,
            selectedStartDate == date {
            self.selectedStartDate = nil
        } else {
            selectedStartDate = date
            selectedDates.append(date)
        }
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
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        collectionView.backgroundColor = scheme.collectionViewBackgroundColor.uiColor
        reloadData()
    }
    
    private func isActiveDay(day: Day) -> Bool {
        if let notActiveAfterDate = notActiveAfterDate, day.date > notActiveAfterDate { return false }
        
        return true
    }
    
    private func updateLocale() {
        calendarGenerator?.locale = locale
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension CalendarVerticalView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let month = months[safe: section] else { return 0 }
        
        return month.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CalendarDayCell,
            let month = months[safe: indexPath.section],
            let day = month.days[safe: indexPath.row],
            let calendarGenerator = calendarGenerator
        else {
            return UICollectionViewCell()
        }
        
        var isActive = true
        if let notActiveAfterDate = notActiveAfterDate {
            isActive = !(day.date > notActiveAfterDate)
        }
        let isSelected = selectedDates.contains(where: {
            calendarGenerator.compareDate(
                firstDate: $0,
                secondDate: day.date,
                with: .day,
                byOrder: .orderedSame)
        }) && day.isDisplayedInMonth
        
        var isStartDate = false
        var isEndDate = false
        
        if let selectedStartDate = selectedStartDate {
            isStartDate = calendarGenerator.compareDate(
                firstDate: day.date,
                secondDate: selectedStartDate,
                with: .day,
                byOrder: .orderedSame)
        }
        
        if let selectedEndDate = selectedEndDate {
            isEndDate = calendarGenerator.compareDate(
                firstDate: day.date,
                secondDate: selectedEndDate,
                with: .day,
                byOrder: .orderedSame)
        }
        
        let isTail = isStartDate || isEndDate
        let hasPoint = Set(pointDates).contains(day.date.removeTimeStamp())
        
        cell.configureWith(
            model: .init(
                title: day.number,
                isDisplayedInMonth: day.isDisplayedInMonth,
                isSelected: isSelected,
                isTail: isTail,
                isCurrentDay: day.isCurrentDay,
                isActive: isActive,
                hasPoint: hasPoint,
                accesibilityId: day.date.dateToString()
            )
        )
        cell.scheme = scheme.calendarViewCellColorScheme
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if
            kind == UICollectionView.elementKindSectionHeader,
            let month = months[safe: indexPath.section],
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as? CalendarHeaderView {
            
            sectionHeader.configureWith(model: .init(title: month.title))
            sectionHeader.locale = locale
            sectionHeader.scheme = scheme.calendarHeaderViewScheme
            return sectionHeader
        } else if let sectionFooter = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Constants.footerIdentifier, for: indexPath) as? CalendarFooterView {
            sectionFooter.scheme = scheme.calendarFooterViewColorScheme
            return sectionFooter
        }
        return UICollectionReusableView()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarVerticalView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard
            let month = months[safe: indexPath.section],
            let day = month.days[safe: indexPath.row],
            isActiveDay(day: day) else { return false }
        
        return calendarDelegate?.shouldSelectDate?(date: day.date, itemAt: indexPath) ?? true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard
            let month = months[safe: indexPath.section],
            let day = month.days[safe: indexPath.row],
            isActiveDay(day: day) else { return false }
        
        return calendarDelegate?.shouldDeselectDate?(date: day.date, forItemAt: indexPath) ?? true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let month = months[safe: indexPath.section],
            let day = month.days[safe: indexPath.row],
            isActiveDay(day: day),
            day.isDisplayedInMonth else { return }

        prepareSelectedDates(date: day.date)
        calendarDelegate?.didSelectDates?(dates: selectedDates, itemAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let month = months[safe: indexPath.section],
            let day = month.days[safe: indexPath.row],
            isActiveDay(day: day),
            day.isDisplayedInMonth else { return }
        
        prepareSelectedDates(date: day.date)
        calendarDelegate?.didDeselectDates?(dates: selectedDates, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: LayoutGrid.halfModule * 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: LayoutGrid.halfModule * 17)
    }
    
}
