//
//  ButtonWithArrowListView.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A view object with arrow image view.
public class ButtonWithArrowListView: BaseListView, TralingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the button displays.
    public var title: String? {
        didSet { ghostButton.setTitle(title, for: .normal) }
    }
    
    /// The closure sign that button did select.
    public var didSelect: (() -> Void)?
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    var scheme = ButtonWithArrowListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let ghostButton = UIButton()
    private let arrowImageView = UIImageView()
    
    private var viewBackgroundColor = ControlParameter<UIColor>()
    private var buttonTextColor = ControlParameter<UIColor>()
    private var buttonBackgroundColor = ControlParameter<UIColor>()
    
    private var arrowImageTintColor = ControlParameter<UIColor>()

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
        scheme = ButtonWithArrowListViewScheme(theme: theme)
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
        ghostButton.backgroundColor = scheme.buttonBackgroundColor.parameter(for: state)?.uiColor
        ghostButton.setTitleColor(scheme.buttonTextColor.parameter(for: state)?.uiColor, for: state)
        
        arrowImageView.tintColor = scheme.arrowImageTintColor.parameter(for: state)?.uiColor
        
        ghostButton.isEnabled = state == .normal ? true : false
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [ghostButton, arrowImageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            ghostButton.topAnchor.constraint(equalTo: topAnchor),
            ghostButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: ghostButton.bottomAnchor),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            arrowImageView.leadingAnchor.constraint(equalTo: ghostButton.trailingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            arrowImageView.centerYAnchor.constraint(equalTo: ghostButton.centerYAnchor)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        ghostButton.titleLabel?.textAlignment = .right
        ghostButton.contentMode = .right
        arrowImageView.contentMode = .center
        arrowImageView.image = PrivateAsset.Custom.Cell.arrowDown.image
        
        ghostButton.addTarget(self, action: #selector(buttonDidSelect(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonDidSelect(_ button: UIButton) {
        didSelect?()
    }
    
}
