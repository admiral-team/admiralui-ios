//
//  CalendarView.swift
//  AdmiralUIKit
//
//  Created on 01.12.2021.
//

import AdmiralTheme
import UIKit

/// Calendar view type. Is presented in two versions: Vertical Mode and Horizontal Mode.
public enum CalendarViewType: String {
    case horizontal
    case vertical
}

/**
 Calendar view let users select a date, or a range of dates.
 
 This component is presented in two versions: Vertical Mode and Horizontal Mode. Additionally, you can configure parameters
 such as the locale, start date, end date, selected start date, selected end date, the date month that will appear when the calendar appears, and disabled dates after a certain date.
 
 The vertical calendar can be scrolled vertically, presented in the form of a table and divided into sections. Each section is a specific month.
 
 A horizontal calendar is a display of the month. Switching between months and years is carried out using the left and right buttons. You can also switch between months using picker view.
 
 You can create a CalendarView by specifying the following parameters in the initializer
 ## Initializer parameters:
 - type: Type calendar.
 
 ## Example for the vertical calendar view with disabled dates after a current date:
 # Code
 ```
 let calendarView = CalendarView(type: .vertical)
 calendarView.calendarDataSource = self
 calendarView.calendarDelegate = self
 calendarView.notActiveAfterDate = Date()
 calendarView.reloadData()
 ```
 To set the start and end date of the calendar, you will need to subscribe
 to the calendarDataSource and implement startDate and endDate.
 To receive events about a change in the date range, you must subscribe to the calendarDelegate.
 

 ## Example for the horizontal calendar view with disabled dates after a current date:
 # Code
 ```
 let calendarView = CalendarView(type: .horizontal)
 calendarView.calendarDataSource = self
 calendarView.calendarDelegate = self
 calendarView.notActiveAfterDate = Date()
 calendarView.reloadData()
 ```
 */
public class CalendarView: UIView, AnyAppThemable {
    
    /// The calendar delegate.
    public weak var calendarDelegate: CalendarDelegate? {
        didSet {
            setDelegatesCalendarViews()
        }
    }
    public weak var calendarDataSource: CalendarDataSource? {
        didSet {
            setDelegatesCalendarViews()
        }
    }
    
    
    /// Calendar locale.
    public var locale: Locale? {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.locale
            case .horizontal:
                return calendarHorizontalView?.locale
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.locale = newValue
            case .horizontal:
                calendarHorizontalView?.locale = newValue
            }
        }
    }
    
    /// Not active after date.
    public var notActiveAfterDate: Date? {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.notActiveAfterDate
            case .horizontal:
                return calendarHorizontalView?.notActiveAfterDate
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.notActiveAfterDate = newValue
            case .horizontal:
                calendarHorizontalView?.notActiveAfterDate = newValue
            }
        }
    }
    
    /// Select start date.
    public var selectedStartDate: Date? {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.selectedStartDate
            case .horizontal:
                return calendarHorizontalView?.selectedStartDate
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.setStartSelectedDate(newValue)
            case .horizontal:
                calendarHorizontalView?.setStartSelectedDate(newValue)
            }
        }
    }
    
    /// Dates with a dot at the bottom.
    public var pointDates: [Date] {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.pointDates ?? []
            case .horizontal:
                return calendarHorizontalView?.pointDates ?? []
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.pointDates = newValue.map( { $0.removeTimeStamp() } )
            case .horizontal:
                calendarHorizontalView?.pointDates = newValue.map( { $0.removeTimeStamp() } )
            }
        }
    }
    
    /// Select end date.
    public var selectedEndDate: Date? {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.selectedEndDate
            case .horizontal:
                return calendarHorizontalView?.selectedEndDate
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.setEndSelectedDate(newValue)
            case .horizontal:
                calendarHorizontalView?.setEndSelectedDate(newValue)
            }
        }
    }
    
    /// Flag for mutliple selection.
    public var isMutlipleSelectionAllowed: Bool {
        get {
            switch type {
            case .vertical:
                return calendarVerticalView?.isMutlipleSelectionAllowed ?? true
            case .horizontal:
                return calendarHorizontalView?.isMutlipleSelectionAllowed ?? true
            }
        }
        set {
            switch type {
            case .vertical:
                calendarVerticalView?.isMutlipleSelectionAllowed = newValue
            case .horizontal:
                calendarHorizontalView?.isMutlipleSelectionAllowed = newValue
            }
        }
    }

    /// Color scheme.
    public var scheme = CalendarViewScheme() {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private var type: CalendarViewType = .vertical
    private var calendarHorizontalView: CalendarHorizontalView?
    private var calendarVerticalView: CalendarVerticalView?
    
    // MARK: - Initiliazers
    
    public init(type: CalendarViewType) {
        super.init(frame: .zero)
        self.type = type
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    
    public func reloadData() {
        switch type {
        case .horizontal:
            calendarHorizontalView?.reloadData()
        case .vertical:
            calendarVerticalView?.reloadData()
        }
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        scheme = CalendarViewScheme(theme: theme)
    }
    
    // MARK: - Private Properties
    
    private func commonInit() {
        addSubviews()
    }
    
    private func addSubviews() {
        switch type {
        case .vertical:
            let calendarVerticalView = CalendarVerticalView()
            [calendarVerticalView].forEach({
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            })
            self.calendarVerticalView = calendarVerticalView
            NSLayoutConstraint.activate(fillView(view: calendarVerticalView))
        case .horizontal:
            let calendarHorizontalView = CalendarHorizontalView()
            [calendarHorizontalView].forEach({
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            })
            self.calendarHorizontalView = calendarHorizontalView
            NSLayoutConstraint.activate(fillView(view: calendarHorizontalView))
        }
    }
    
    private func setDelegatesCalendarViews() {
        switch type {
        case .vertical:
            calendarVerticalView?.calendarDelegate = calendarDelegate
            calendarVerticalView?.calendarDataSource = calendarDataSource
        case .horizontal:
            calendarHorizontalView?.calendarDelegate = calendarDelegate
            calendarHorizontalView?.calendarDataSource = calendarDataSource
        }
    }
    
    private func configure() {
        calendarVerticalView?.scheme = scheme.calendarVerticalViewScheme
        calendarHorizontalView?.scheme = scheme.calendarHorizontalViewScheme
    }

}
