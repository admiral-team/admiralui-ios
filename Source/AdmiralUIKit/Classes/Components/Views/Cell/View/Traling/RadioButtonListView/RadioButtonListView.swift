//
//  RadioButtonListView.swift
//  AdmiralUI
//
//  Created on 16.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A view object with radio button.
public class RadioButtonListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: - Public Properties

    /// A Boolean value indicating whether the check box view is in the selected state.
    public var isSelected: Bool = false {
        didSet { radioButton.isSelected = isSelected }
    }

    /// Radio button controlState.
    public var controlState: CheckControlState = .normal {
        didSet {
            radioButton.checkState = controlState
        }
    }

    /// Radio button title text.
    public var text: String? = nil {
        didSet {
            radioButton.text = text
        }
    }

    /// Enable control flag.
    public override var isEnabled: Bool {
        get {
            return radioButton.isEnabled
        } set {
            radioButton.isEnabled = newValue
        }
    }

    /// Color scheme.
    public var scheme = RadioButtonListViewScheme() {
        didSet { updateScheme() }
    }

    /// Tap action.
    public var didSelect: (() -> Void)?
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties

    private let radioButton = CheckTextControl<RadioControl>(checkControl: RadioControl())

    // MARK: - Initializer
    
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
        scheme = RadioButtonListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        radioButton.scheme = scheme.radioButtonScheme
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [radioButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            radioButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: LayoutGrid.module)
        ])
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        radioButton.text = nil
        radioButton.isSelected = false
        radioButton.checkState = .normal
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        radioButton.addGestureRecognizer(gesture)
    }

    @objc private func didTap(_ tap: UITapGestureRecognizer) {
        radioButton.isSelected = !radioButton.isSelected
        didSelect?()
    }

}
