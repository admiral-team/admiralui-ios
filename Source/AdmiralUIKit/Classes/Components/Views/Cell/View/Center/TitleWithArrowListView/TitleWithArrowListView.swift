//
//  TitleWithArrowListView.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A view object with title.
public class TitleWithArrowListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }

    /// Color scheme.
    public var scheme = TitleWithArrowListViewScheme() {
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
    private let arrowImageView = UIImageView()

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
        scheme = TitleWithArrowListViewScheme(theme: theme)
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
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.viewBackgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.parameter(for: state)?.uiColor
        arrowImageView.tintColor = scheme.arrowImageTintColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel, arrowImageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            arrowImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        titleLabel.numberOfLines = 1
        arrowImageView.contentMode = .center
        arrowImageView.image = Asset.System.Outline.chevronDownOutline.image
    }
    
}
