//
//  HorizontalCalendarView.swift
//  AdmiralUIKit
//
//  Created on 09.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

class CalendarHorizontalView: UIView, AnyAppThemable {

    enum Constants {
        static let cellIdentifier: String = "horizontalCell"
        static let calendarHeight: CGFloat = 367.0
        static let minimumLineSpacing: CGFloat = LayoutGrid.doubleModule
        static let viewDivider: CGFloat = LayoutGrid.halfModule
        static let monthFormat = "LLLL"
        static let yearFormat = "yyyy"
    }
    
    // MARK: - Internal Properties
    
    var locale: Locale? {
        didSet { updateLocale() }
    }
    
    /// The calendar delegate.
    weak var calendarDelegate: CalendarDelegate?
    weak var calendarDataSource: CalendarDataSource?
    
    /// Select start date.
    var selectedStartDate: Date?
    
    /// Select end date.
    var selectedEndDate: Date?
    
    var isMutlipleSelectionAllowed: Bool = true
    
    /// Not active after date.
    var notActiveAfterDate: Date?
    
    var pointDates: [Date] = [] {
        didSet { collectionView.reloadData() }
    }
    
    var scheme = CalendarHorizontalViewScheme() {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private var preDate: Date?
    private var currentDate = Date() {
        didSet {
            updateCurrentDate()
        }
    }
    private var scrollIndex = 0
    private var nextDate: Date?
    private var dates: [Date] = []
    private var calendarGenerator: CalendarGeneratorDelegate?
    private var isShowDatePicker: Bool = false {
        didSet {
            weekView.isHidden = isShowDatePicker
            datePickerView.isHidden = !isShowDatePicker
            collectionView.isHidden = isShowDatePicker
        }
    }
    
    private let weekView = WeekView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CalendarHorizontalViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()
    private var datePickerView = MonthYearPickerView()
    
    private var calendarHorizontalHeaderView = CalendarHorizontalHeaderView()
    
    // MARK: - Initiliazers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.scrollToItem(
            at: IndexPath(
                item: scrollIndex,
                section: 0),
            at: .centeredHorizontally,
            animated: false)
        updateHorizontalHeaderViewDate()
    }
    
    func reloadData() {
        setDates()
        updateHorizontalHeaderViewDate()
        setPickerView()
    }
    
    func setStartSelectedDate(_ date: Date?) {
        guard let date = date else {
            if let selectedEndDate = selectedEndDate {
                prepareSelectedDates(date: selectedEndDate)
            } else {
                selectedStartDate = nil
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
        scheme = CalendarHorizontalViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        calendarGenerator = CalendarGenerator()
        isShowDatePicker = false
        
        addSubviews()
        setPickerView()
        setConstraints()
        setHorizontalHeaderView()
    }
    
    private func setDates() {
        guard
            let calendarGenerator = calendarGenerator
        else { return }
        
        let startDate = calendarDataSource?.startDate ?? Date.distantPast
        let endDate = calendarDataSource?.endDate ?? Date.distantFuture
        
        var dates = [Date]()
        var index = 0
        
        let preMonthDate = calendarGenerator.calculatePreviousMonthData(currentDate: currentDate, startDate: startDate)
        let nextMonthdate = calendarGenerator.calculateNextMonthData(currentDate: currentDate, endDate: endDate)
        
        if let preMonthDate = preMonthDate {
            dates.append(preMonthDate)
            index = 1
        }
        dates.append(currentDate)
        if let nextMonthdate = nextMonthdate {
            dates.append(nextMonthdate)
            index = dates.count == 3 ? 1 : 0
        }
        
        self.dates = dates
        self.scrollIndex = index
        collectionView.reloadData()
        collectionView.scrollToItem(
            at: IndexPath(
                item: index,
                section: 0),
            at: .centeredHorizontally,
            animated: false)
    }
    
    private func setHorizontalHeaderView() {
        calendarHorizontalHeaderView.delegate = self
        calendarHorizontalHeaderView.isArrowUp = true
    }
    
    private func setPickerView() {
        datePickerView.startDate = calendarDataSource?.startDate ?? Date.distantPast
        datePickerView.endDate = calendarDataSource?.endDate ?? Date.distantFuture
        datePickerView.monthYearPickerDelegate = self
        datePickerView.setTitles()
    }
    
    private func updateHorizontalHeaderViewDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.yearFormat
        formatter.locale = locale
        var year = formatter.string(from: currentDate)
        
        formatter.dateFormat = Constants.monthFormat
        let month = formatter.string(from: currentDate).capitalized
        if let number = Int(year) {
            year = "\(number)"
        }
        calendarHorizontalHeaderView.title = "\(month) \(year)"
    }
    
    private func addSubviews() {
        [calendarHorizontalHeaderView, weekView, collectionView, datePickerView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            calendarHorizontalHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            calendarHorizontalHeaderView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: calendarHorizontalHeaderView.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            weekView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: weekView.trailingAnchor),
            weekView.topAnchor.constraint(equalTo: calendarHorizontalHeaderView.bottomAnchor, constant: LayoutGrid.module),
            weekView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: weekView.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            
            datePickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerView.topAnchor.constraint(equalTo: calendarHorizontalHeaderView.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor),
            datePickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.calendarHeight),
        ])
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        collectionView.backgroundColor = scheme.collectionViewBackgroundColor.uiColor
        weekView.scheme = scheme.calendarHeaderViewScheme
        calendarHorizontalHeaderView.scheme = scheme.calendarHorizontalHeaderViewScheme
        datePickerView.scheme = scheme.monthYearPickerViewScheme
        reloadData()
    }
    
    private func updateLocale() {
        calendarGenerator?.locale = locale
        datePickerView.locale = locale
        weekView.locale = locale
    }
    
    private func updateCurrentDate() {
        setDates()
        updateHorizontalHeaderViewDate()
        calendarDelegate?.didChangeMonthDate?(date: currentDate)
    }
    
}

extension CalendarHorizontalView: CalendarHorizontalHeaderViewDelegate {
    
    func calendarHorizontalHeaderTapLeft() {
        scrollLeft()
    }
    
    func calendarHorizontalHeaderTapRight() {
        scrollRight()
    }
    
    func calendarHorizontalHeaderTapDate() {
        collectionView.isHidden = false
        datePickerView.isHidden = false
        weekView.isHidden = false
        
        calendarHorizontalHeaderView.isArrowUp = isShowDatePicker
        datePickerView.year = currentDate
        datePickerView.month = currentDate
        
        UIView.animate(withDuration: Durations.Default.single, delay: 0.0, options: .curveEaseInOut) {
            self.collectionView.alpha = self.isShowDatePicker ? 1.0 : 0.0
            self.datePickerView.alpha = self.isShowDatePicker ? 0.0 : 1.0
            self.weekView.alpha = self.isShowDatePicker ? 1.0 : 0.0
        } completion: { _ in
            self.isShowDatePicker.toggle()
        }
    }
    
    private func scrollLeft() {
        let startDate = calendarDataSource?.startDate ?? Date.distantPast
        guard let preDate = calendarGenerator?.calculatePreviousMonthData(currentDate: currentDate, startDate: startDate),
              self.preDate == nil else { return }
        
        self.preDate = preDate
        
        collectionView.scrollToItem(
            at: IndexPath(
                item: 0,
                section: 0),
            at: .centeredHorizontally,
            animated: true)
    }
    
    private func scrollRight() {
        let endDate = calendarDataSource?.endDate ?? Date.distantFuture
        guard let nextDate = calendarGenerator?.calculateNextMonthData(currentDate: currentDate, endDate: endDate),
              self.nextDate == nil else { return }
        
        self.nextDate = nextDate
        collectionView.scrollToItem(
            at: IndexPath(
                item: dates.count - 1,
                section: 0),
            at: .centeredHorizontally,
            animated: true)
    }
    
    private func prepareMultipleSelectionDates(date: Date, indexPath: IndexPath) {
        if let startDate = selectedStartDate,
           let endDate = selectedEndDate,
           startDate <= date,
           endDate >= date {
            selectedStartDate = date
            selectedEndDate = nil
            return
        }
        
        if let startDate = selectedStartDate, selectedEndDate != nil {
            if startDate > date {
                selectedStartDate = date
            } else {
                selectedEndDate = date
            }
            return
        } else if let startDate = selectedStartDate {
            
            if startDate > date {
                selectedEndDate = selectedStartDate
                selectedStartDate = date
            } else {
                selectedEndDate = date
            }
        } else {
            selectedStartDate = date
        }

        calendarDelegate?.didSelectDates?(
            dates: datesRange(from: selectedStartDate, to: selectedEndDate),
            itemAt: indexPath
        )
    }
    
    private func prepareSingleSelectionDate(date: Date, indexPath: IndexPath) {
        if
            let selectedStartDate = selectedStartDate,
            selectedStartDate == date {
            self.selectedStartDate = nil
        } else {
            self.selectedStartDate = date
        }
        calendarDelegate?.didSelectDates?(
            dates: datesRange(from: selectedStartDate, to: selectedEndDate),
            itemAt: indexPath
        )
    }

    private func datesRange(from: Date?, to: Date?) -> [Date] {
        guard let from = from, let to = to else {
            if let from = from {
                return [from]
            } else {
                return []
            }
        }

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

extension CalendarHorizontalView: MonthYearPickerViewDelegate {
    
    func changeMonthYearPickerView(date: Date) {
        self.currentDate = date
    }
    
}

// MARK: - UICollectionViewDataSource

extension CalendarHorizontalView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CalendarHorizontalViewCell,
            let date = dates[safe: indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.notActiveAfterDate = notActiveAfterDate
        cell.calendarDelegate = calendarDelegate
        cell.calendarHorizontalViewCellDelegate = self
        cell.configureWith(
            date: date,
            selectedStartDate: selectedStartDate,
            selectedEndDate: selectedEndDate,
            pointDates: pointDates)
        cell.scheme = scheme.calendarHorizontalViewCellScheme
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let preDate = preDate {
            currentDate = preDate
            self.preDate = nil
        } else if let nextDate = nextDate {
            currentDate = nextDate
            self.nextDate = nil
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.x - scrollView.frame.width
        if offset > scrollView.frame.width / Constants.viewDivider {
            scrollRight()
        } else if offset < -scrollView.frame.width / Constants.viewDivider {
            scrollLeft()
        } else {
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width + Constants.minimumLineSpacing, y: 0.0), animated: true)
        }
    }
    
}

extension CalendarHorizontalView: CalendarHorizontalViewCellDelegate {
    
    func prepareSelectedDates(date: Date, indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        isMutlipleSelectionAllowed ? prepareMultipleSelectionDates(date: date, indexPath: indexPath) : prepareSingleSelectionDate(date: date, indexPath: indexPath)
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarHorizontalView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}


