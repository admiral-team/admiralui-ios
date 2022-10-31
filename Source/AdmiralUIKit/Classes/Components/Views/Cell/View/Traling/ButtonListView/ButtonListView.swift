//
//  ButtonListView.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with arrow image view.
public class ButtonListView: BaseListView, TralingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the button displays.
    public var title: String? {
        didSet { ghostButton.setTitle(title, for: .normal) }
    }
    
    /// The closure sign that button did select.
    public var didSelect: (() -> Void)?

    /// Color scheme.
    public var scheme = ButtonListViewScheme() {
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
    
    private let ghostButton = UIButton()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = ButtonListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        configure(for: state)
    }
    
    private func updateSchemeFonts() {
        ghostButton.titleLabel?.setDynamicFont(
            font: scheme.buttonFont.uiFont,
            textStyle: scheme.buttonFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        ghostButton.backgroundColor = .clear
        ghostButton.setTitleColor(scheme.buttonTextColor.parameter(for: state)?.uiColor, for: state)
        ghostButton.isEnabled = state == .normal ? true : false
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [ghostButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        let top = ghostButton.topAnchor.constraint(equalTo: topAnchor)
        let leading = ghostButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: ghostButton.trailingAnchor, constant: LayoutGrid.doubleModule)
        let bottom = bottomAnchor.constraint(equalTo: ghostButton.bottomAnchor)

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            bottom
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        ghostButton.titleLabel?.textAlignment = .right
        ghostButton.contentMode = .right
        
        ghostButton.addTarget(self, action: #selector(buttonDidSelect(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonDidSelect(_ button: UIButton) {
        didSelect?()
    }
    
}
