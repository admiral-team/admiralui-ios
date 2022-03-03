//
//  CalendarViewController.swift
//  ExampleiOS
//
//  Created on 18.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class VerticalCalendarViewController: UIViewController, CalendarDataSource, CalendarDelegate, AnyAppThemable {
    
    // MARK: - CalendarVerticalDelegate
    
    var startDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2020 12 01") !! fatalError("Invalid date")
        return date
    }()
    
    var endDate: Date = Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()
    
    // MARK: - Private Properties
    
    private var calendarView = CalendarView(type: .vertical)
    private let themeSwitchView = ThemeSwitchView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Internal Methods
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
        calendarView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        setupCalendarView()
        addSubviews()
        configureConstraints()
    }
    
    private func setupCalendarView() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.notActiveAfterDate = Date()
        calendarView.pointDates = [Date()]
        calendarView.reloadData()
    }
    
    private func addSubviews() {
        [calendarView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
