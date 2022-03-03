//
//  WeekView.swift
//  AdmiralSwiftUI
//
//  Created on 23.11.2021.
//

import AdmiralTheme
import UIKit

class WeekView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var locale: Locale? {
        didSet { setupStackView() }
    }
    
    var scheme = CalendarHeaderViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let dayOfWeekStackView = UIStackView()
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CalendarHeaderViewScheme(theme: theme)
    }
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureWith(model: CalendarHeaderItem) {
        titleLabel.text = model.title
    }
    
    func apply(theme: CalendarHeaderViewScheme) {
        backgroundColor = theme.backgroundColor.uiColor
        titleLabel.textColor = theme.titleLabelColor.uiColor
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupLabels()
        setupStackView()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(dayOfWeekStackView)
    }
    
    private func setupLabels() {
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        dayOfWeekStackView.arrangedSubviews.forEach{
            dayOfWeekStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.getShortWeekdaySymbols(locale).forEach({
            let dayLabel = CalendarDayLabel()
            dayLabel.text = $0
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        })
        
        dayOfWeekStackView.distribution = .fillEqually
        dayOfWeekStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            dayOfWeekStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.module),
            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelColor.uiColor
    }
    
}
