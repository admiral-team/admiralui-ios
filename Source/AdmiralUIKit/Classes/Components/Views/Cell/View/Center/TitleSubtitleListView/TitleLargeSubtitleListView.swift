//
//  TitleLargeSubtitleListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with title and subtitle.
public class TitleLargeSubtitleListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let titleOffsetY = LayoutGrid.halfModule * 3
    }
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    /// The text that the title label displays.
    public var additionalTitle: String? {
        didSet {
            let constant = additionalTitle == nil || additionalTitle?.isEmpty == true ? 0 : LayoutGrid.doubleModule
            additionalTitleTrailingConstraint.constant = constant
            additionalTitleLabel.text = additionalTitle
        }
    }
    
    /// The text that the subtitle label displays.
    public var subtitle: String? {
        didSet {
            let constant = subtitle == nil || subtitle?.isEmpty == true ? 0 : Constants.titleOffsetY
            titleCenterYConstraint.constant = constant
            subtitleLabel.text = subtitle
        }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { updateScheme() }
    }
    
    public var scheme = TitleLargeSubtitleScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let additionalTitleLabel = UILabel()
    
    private lazy var titleCenterYConstraint: NSLayoutConstraint = {
        return centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: Constants.titleOffsetY)
    }()
    
    private lazy var additionalTitleTrailingConstraint: NSLayoutConstraint = {
        return trailingAnchor.constraint(equalTo: additionalTitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
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
        scheme = TitleLargeSubtitleScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel,
         subtitleLabel,
         additionalTitleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        let subtitleCenterY = subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        subtitleCenterY.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            titleCenterYConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.trailingAnchor.constraint(equalTo: additionalTitleLabel.leadingAnchor, constant: -LayoutGrid.module),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            titleCenterYConstraint,
            
            additionalTitleLabel.centerYAnchor.constraint(greaterThanOrEqualTo: titleLabel.centerYAnchor),
            additionalTitleTrailingConstraint,
            
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
        additionalTitleLabel.numberOfLines = 1
        additionalTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
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
        additionalTitleLabel.setDynamicFont(
            font: scheme.additionalTitleFont.uiFont,
            textStyle: scheme.additionalTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleColor.parameter(for: state)?.uiColor
        additionalTitleLabel.textColor = scheme.additionaColor.parameter(for: state)?.uiColor
    }
    
}
