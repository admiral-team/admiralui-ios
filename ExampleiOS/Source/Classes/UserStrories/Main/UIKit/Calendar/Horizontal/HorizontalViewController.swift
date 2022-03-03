//
//  HorizontalViewController.swift
//  ExampleiOS
//
//  Created on 11.11.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class HorizontalViewController: UIViewController, AnyAppThemable, CalendarDataSource, CalendarDelegate {
    
    // MARK: - Private Properties
    
    private var calendarView = CalendarView(type: .horizontal)
    private let themeSwitchView = ThemeSwitchView()
    private var isThemeSwitchButtonHidden = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
        calendarView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        setupCalendarView()
        addSubviews()
        configureConstraints()
        addThemeSwitchView(themeSwitchView)
    }
    
    private func setupCalendarView() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.notActiveAfterDate = Date()
        calendarView.pointDates = [Date()]
        calendarView.reloadData()
    }
    
    private func addSubviews() {
        [themeSwitchView,
         calendarView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func tapThemeSwitchButton(_ button: UIButton) {
        themeSwitchView.setIsHidden(!button.isSelected, animated: true)
        
        if !themeSwitchView.isHidden {
            themeSwitchView.reloadData()
        }
    }
    
}
