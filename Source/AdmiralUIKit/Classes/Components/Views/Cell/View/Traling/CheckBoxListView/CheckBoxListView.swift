//
//  CheckBoxView.swift
//  AdmiralUI
//
//  Created on 16.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with check box view.
open class CheckBoxListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: - Public Properties

    /// A Boolean value indicating whether the check box view is in the selected state.
    public var isSelected: Bool = false {
        didSet { checkBox.isSelected = isSelected }
    }

    /// Checkbox controlState.
    public var controlState: CheckControlState = .normal {
        didSet {
            checkBox.checkState = controlState
        }
    }

    /// Checkbox title text.
    public var text: String? = nil {
        didSet {
            checkBox.text = text
        }
    }

    /// Enable control flag.
    public override var isEnabled: Bool {
        get {
            return checkBox.isEnabled
        } set {
            checkBox.isEnabled = newValue
        }
    }

    /// Color scheme.
    public var scheme = CheckBoxListViewScheme() {
        didSet { updateScheme() }
    }
    
    /// The check box accessibility id
    public var checkBoxAccesibilityId: String? {
        didSet {
            checkBox.checkControlAccesibilityId = checkBoxAccesibilityId
        }
    }

    /// Tap action.
    public var didSelect: (() -> Void)?
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties

    /// CheckBox button control.
    private let checkBox = CheckTextControl<CheckBox>(checkControl: CheckBox())

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = CheckBoxListViewScheme(theme: theme)
        checkBox.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        checkBox.scheme = scheme.checkBoxScheme
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [checkBox].addToSuperview(self)
    }
    
    private func configureLayout() {        
        NSLayoutConstraint.activate([
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: checkBox.trailingAnchor)
        ])
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeCheckBox(_:)))
        checkBox.apply(theme: defaultTheme)
        checkBox.text = nil
        checkBox.isSelected = false
        checkBox.addGestureRecognizer(gesture)
    }

    @objc private func changeCheckBox(_ tap: UITapGestureRecognizer) {
        checkBox.isSelected = !checkBox.isSelected
        didSelect?()
    }

}

