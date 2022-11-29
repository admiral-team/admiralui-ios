//
//  TitleSubtitleListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with title and subtitle.
public class TitleSubtitleListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let titleOffsetY = LayoutGrid.halfModule * 3
    }
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    /// The text that the subtitle label displays.
    public var subtitle: String? {
        didSet {
            let constant = subtitle == nil || subtitle?.isEmpty == true ? 0 : Constants.titleOffsetY
            titleCenterYConstraint.constant = constant
            subtitleLabel.text = subtitle
        }
    }

    public var scheme = TitleSubtitleListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private lazy var titleCenterYConstraint: NSLayoutConstraint = {
        return centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: Constants.titleOffsetY)
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
        scheme = TitleSubtitleListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel,
         subtitleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        let subtitleCenterY = subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        subtitleCenterY.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            titleCenterYConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            titleCenterYConstraint,
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            subtitleCenterY,
            bottomAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
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
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleColor.parameter(for: state)?.uiColor
    }
    
}
