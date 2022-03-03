//
//  DatePercentListView.swift
//  AdmiralUI
//
//  Created on 18.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with date and percent label.
public class DatePercentListView: BaseListView, TralingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the date label displays.
    public var date: String? {
        didSet { titleLabel.text = date }
    }
    
    /// The text that the percent label displays.
    public var percent: String? {
        didSet { subtitleLabel.text = percent }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    var scheme = DatePercentListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = DatePercentListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        configure(for: state)
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel, subtitleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        let subtitleCenterY = subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        subtitleCenterY.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor),
            subtitleCenterY
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.textAlignment = .right
        titleLabel.numberOfLines = 1
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .right
    }
    
}
