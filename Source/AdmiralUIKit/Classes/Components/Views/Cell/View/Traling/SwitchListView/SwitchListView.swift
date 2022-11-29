//
//  SwitchListView.swift
//  AdmiralUI
//
//  Created on 16.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with switch view.
public class SwitchListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// A Boolean value indicating whether the switch view is in the selected state.
    public var isControlSelected: Bool = false {
        didSet { customSwitch.isOn = isControlSelected }
    }
    
    /// The closure sign that switch view did select.
    public var didSelect: ((Bool) -> Void)?

    /// Color scheme.
    public var scheme = SwitchListViewScheme() {
        didSet { updateScheme() }
    }

    /// The switcher accessibility id
    public var customSwitchAccesibilityId: String? {
        didSet {
            customSwitch.accessibilityIdentifier = customSwitchAccesibilityId
        }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties
    
    private let customSwitch = CustomSwitch()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
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
        customSwitch.apply(theme: theme)
        scheme = SwitchListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        customSwitch.isEnabled = isEnabled
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [customSwitch].addToSuperview(self)
    }
    
    private func configureLayout() {
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.doubleModule * 4)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            customSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: customSwitch.trailingAnchor, constant: LayoutGrid.doubleModule),
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        customSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func switchValueChanged(_ switchView: UISwitch) {
        didSelect?(switchView.isOn)
        isControlSelected = switchView.isOn
    }
    
}
