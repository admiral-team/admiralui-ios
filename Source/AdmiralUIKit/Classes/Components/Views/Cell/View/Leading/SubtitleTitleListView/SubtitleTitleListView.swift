//
//  SubtitleTitleListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with subtitle and title.
public class SubtitleTitleListView: BaseListView, LeadingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let subtitleOffsetY = LayoutGrid.halfModule * 3
    }
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var title: String? {
        didSet {
            let constant = title == nil || title?.isEmpty == true ? 0 : Constants.subtitleOffsetY
            subtitleCenterYConstraint.constant = constant
            titleLabel.text = title
        }
    }
    
    /// The text that the subtitle label displays.
    public var subtitle: String? {
        didSet { subtitleLabel.text = subtitle }
    }

    /// Color scheme.
    public var scheme = SubtitleTitleListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private lazy var subtitleCenterYConstraint: NSLayoutConstraint = {
        return centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor, constant: Constants.subtitleOffsetY)
    }()

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
        scheme = SubtitleTitleListViewScheme(theme: theme)
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
        let titleCenterY = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        titleCenterY.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            subtitleCenterYConstraint,
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor),
            titleCenterY
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
    }

}
