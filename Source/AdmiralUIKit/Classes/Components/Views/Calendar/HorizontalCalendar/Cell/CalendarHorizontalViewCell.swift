//
//  CalendarHorizontalViewCell.swift
//  AdmiralUIKit
//
//  Created on 16.11.2021.
//

import AdmiralTheme
import UIKit

protocol CalendarHorizontalViewCellDelegate: AnyObject {
    func prepareSelectedDates(date: Date)
}

class CalendarHorizontalViewCell: UICollectionViewCell, AnyAppThemable {
    
    enum Constants {
        static let cellIdentifier: String = "cell"
    }
    
    // MARK: - Public Properties
    
    /// The calendar delegate.
    weak var calendarHorizontalViewCellDelegate: CalendarHorizontalViewCellDelegate?
    weak var calendarDelegate: CalendarDelegate?
    
    var notActiveAfterDate: Date?
    
    var days: [Day] = [] {
        didSet { collectionView.reloadData() }
    }
    
    var pointDates: [Date] = [] {
        didSet { collectionView.reloadData() }
    }
    
    var scheme = CalendarHorizontalViewCellScheme() {
        didSet { updateScheme()  }
    }
    
    // MARK: - Private Properties

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
        collectionView.alwaysBounceVertical = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CalendarDayCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()
    
    private var selectedStartDate: Date?
    private var selectedEndDate: Date?
    
    private var calendarGenerator: CalendarGeneratorDelegate?

    private var state: CalendarCellState = .normal {
        didSet { updateScheme()  }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods

    func configureWith(date: Date, selectedStartDate: Date?, selectedEndDate: Date?, pointDates: [Date]) {
        let generator = CalendarGenerator()
        var days = [Day]()
        if let monthMetadata = generator.monthMetadata(for: date) {
            days = generator.generateDaysInMonth(metadata: monthMetadata)
        }
        self.days = days
        self.selectedStartDate = selectedStartDate
        self.selectedEndDate = selectedEndDate
        self.pointDates = pointDates
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CalendarHorizontalViewCellScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        calendarGenerator = CalendarGenerator()
        
        apply(theme: .default)
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        collectionView.backgroundColor = scheme.backgroundColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
    private func isActiveDay(day: Day) -> Bool {
        if let notActiveAfterDate = notActiveAfterDate, day.date > notActiveAfterDate { return false }
        
        return true
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

}

// MARK: - UICollectionViewDataSource

extension CalendarHorizontalViewCell: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CalendarDayCell,
            let day = days[safe: indexPath.row],
            let calendarGenerator = calendarGenerator
        else {
            return UICollectionViewCell()
        }
        
        var isActive = true
        if let notActiveAfterDate = notActiveAfterDate {
            isActive = !(day.date > notActiveAfterDate)
        }
        let isSelected = checkSelect(date: day.date) && day.isDisplayedInMonth
        
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
        
        cell.configureWith(model: .init(
                            title: day.number,
                            isDisplayedInMonth: day.isDisplayedInMonth,
                            isSelected: isSelected,
                            isTail: isTail,
                            isCurrentDay: day.isCurrentDay,
                            isActive: isActive,
                            hasPoint: hasPoint))
        cell.scheme = scheme.calendarViewCellColorScheme
        return cell
    }
    
    private func checkSelect(date: Date) -> Bool {
        
        let startDate = selectedStartDate?.removeTimeStamp()
        let endDate = selectedEndDate?.removeTimeStamp()

        if let startDate = startDate, startDate <= date {
            if startDate == date {
                return true
            } else if let endDate = endDate, endDate >= date {
                return true
            }
        }
        return false
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarHorizontalViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let day = days[safe: indexPath.row], isActiveDay(day: day) else { return false }
        
        
        return calendarDelegate?.shouldSelectDate?(date: day.date, itemAt: indexPath) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard let day = days[safe: indexPath.row], isActiveDay(day: day) else { return false }
        
        return calendarDelegate?.shouldDeselectDate?(date: day.date, forItemAt: indexPath) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let day = days[safe: indexPath.row],
            day.isDisplayedInMonth,
            isActiveDay(day: day) else { return }
        
        calendarHorizontalViewCellDelegate?.prepareSelectedDates(date: day.date)
        calendarDelegate?.didSelectDates?(
            dates: datesRange(from: selectedStartDate, to: selectedEndDate),
            itemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let day = days[safe: indexPath.row],
            day.isDisplayedInMonth,
            isActiveDay(day: day) else { return }
        
        calendarHorizontalViewCellDelegate?.prepareSelectedDates(date: day.date)
        calendarDelegate?.didDeselectDates?(
            dates: datesRange(from: selectedStartDate, to: selectedEndDate),
            forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: LayoutGrid.halfModule * 15)
    }
    
}
