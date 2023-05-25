//
//  MonthYearPickerView.swift
//  AdmiralUIResources
//
//  Created on 18.11.2021.
//

import AdmiralTheme
import UIKit

protocol MonthYearPickerViewDelegate: AnyObject {
    func changeMonthYearPickerView(date: Date)
}

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var locale: Locale? {
        didSet { calendar.locale = locale }
    }
    weak var monthYearPickerDelegate: MonthYearPickerViewDelegate?
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    var scheme = MonthYearPickerViewScheme() {
        didSet { self.reloadAllComponents()  }
    }
    
    var month = Date() {
        didSet {
            var currentMonthIndex = Calendar(identifier: .gregorian).component(.month, from: month)
            if selectedRow(inComponent: 1) == 0 {
                currentMonthIndex -= (12 - beginningMonths.count)
            }
            selectRow(max(currentMonthIndex - 1, 0), inComponent: 0, animated: false)
        }
    }

    var year = Date() {
        didSet {
            let title = year.dateToString(dateFormat: "yyyy").capitalized
            if let yearIndex = years.firstIndex(of: title) {
                selectRow(yearIndex, inComponent: 1, animated: false)
            }
        }
    }
    
    // MArK: - Private Properties
    
    private var beginningMonths = [String]()
    private var allMonths = [String]()
    private var months = [String]()
    private var endMonths = [String]()
    
    private var years = [String]()
    
    private var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        return calendar
    }()
    
    // MARK : - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = MonthYearPickerViewScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func commonInit() {
        apply(theme: defaultTheme)
        
        delegate = self
        dataSource = self
    }
    
    func setTitles() {
        var years: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        
        guard let totalYears = calendar.dateComponents(
            [.year],
            from: startDate,
            to: calendar.endOfYear(endDate)).year
        else { return }
        
        for yearIndex in 0...totalYears {
            if
                let currentMonthDate = calendar.date(byAdding: .year, value: yearIndex, to: startDate) {
                let title = currentMonthDate.dateToString(dateFormat: "yyyy").capitalized
                if let number = Int(title) {
                    years.append("\(number)")
                }
            }
        }
        self.years = years
        
        if let totalStartMonth = calendar.dateComponents([.month],
                                                         from: startDate,
                                                         to: calendar.endOfYear(startDate)).month {
            var months = [String]()
            for monthIndex in (11 - totalStartMonth)...11 {
                months.append(dateFormatter.standaloneMonthSymbols[monthIndex].capitalized)
            }
            self.beginningMonths = months
        }
        let endFinalDate =  Calendar.current.nextMonth(endDate).startOfMonth().removeTimeStamp()
        if let totalEndMonth = calendar.dateComponents([.month],
                                                       from: calendar.startOfYear(endDate),
                                                       to: endFinalDate).month {
            var months = [String]()
            for monthIndex in 0..<totalEndMonth {
                months.append(dateFormatter.standaloneMonthSymbols[monthIndex].capitalized)
            }
            self.endMonths = months
        }
        
        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(dateFormatter.standaloneMonthSymbols[month].capitalized)
            month += 1
        }
        self.allMonths = months
        self.months = allMonths
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return years[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedRow(inComponent: 1) == 0 {
            months = beginningMonths
            if selectedRow(inComponent: 0) > beginningMonths.count {
                selectRow(0, inComponent: 0, animated: false)
            }
            pickerView.reloadAllComponents()
        } else if selectedRow(inComponent: 1) == years.count - 1 {
            months = endMonths
            if selectedRow(inComponent: 0) > endMonths.count {
                selectRow(0, inComponent: 0, animated: false)
            }
            pickerView.reloadAllComponents()
        } else {
            let updateAllComponents = months != allMonths
            months = allMonths
            if updateAllComponents {
                pickerView.reloadAllComponents()
            }
        }
        
        let month = months[safe: selectedRow(inComponent: 0)] ?? months.first
        let year = years[selectedRow(inComponent: 1)]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy LLLL dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.locale = locale
        if let month = month, let date = formatter.date(from: "\(year) \(month) 16") {
            monthYearPickerDelegate?.changeMonthYearPickerView(date: date)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let text = component == 0 ? months[row] : years[row]
        return NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : scheme.textColor.uiColor])
    }
    
}

