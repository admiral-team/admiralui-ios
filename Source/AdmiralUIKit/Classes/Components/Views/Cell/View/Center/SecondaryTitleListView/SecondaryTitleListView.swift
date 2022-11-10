//
//  SecondaryTitleListView.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with title.
public class SecondaryTitleListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }

    /// Color scheme.
    public var scheme = SecondaryTitleListViewScheme() {
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
        scheme = SecondaryTitleListViewScheme(theme: theme)
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
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        let top = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
        let bottom = bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            bottom
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        titleLabel.numberOfLines = 0
    }
    
}
