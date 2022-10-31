//
//  InfoAgreementView.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme

/// Delegate InfoAgreementView.
public protocol InfoAgreementViewDelegate: AnyObject {
    func checkBoxShouldSelected(_ checkBox: CheckBox) -> Bool
}

/// Complex user interface element which contains checkbox, title label and transparent button with text.
public class InfoAgreementView: UIView, AnyAppThemable {
        
    // MARK: - Public Properties
    
    /// Delegate SegmentButtonsView.
    public weak var delegate: InfoAgreementViewDelegate?
    
    /// A Boolean value indicating whether the checkbox selected.
    public var isSelected: Bool = false {
        didSet { checkBoxTextButtonView.isSelected = isSelected }
    }
    
    /// A Boolean value indicating whether the InfoAgreementView isEnabled.
    public var isEnabled: Bool = true {
        didSet {
            actionButton.isEnabled = isEnabled
            alternativeButton.isEnabled = isEnabled
            checkBoxTextButtonView.isEnabled = isEnabled
        }
    }
    
    /// Text for check box.
    public var checkboxText: String? {
        didSet {
            checkBoxTextButtonView.text = checkboxText
            updateItems()
        }
    }
    
    /// Text for buttom botton checkbox.
    public var checkboxButtonText: String? {
        didSet {
            checkBoxTextButtonView.checkboxButtonText = checkboxButtonText
            updateItems()
        }
    }
    
    /// Text for action button.
    public var actionText: String? {
        didSet {
            actionButton.setTitle(actionText, for: .normal)
            updateItems()
        }
    }
    
    /// Text for alternative button.
    public var alternativeText: String? {
        didSet {
            alternativeButton.setTitle(alternativeText, for: .normal)
            updateItems()
        }
    }

    /// Color scheme.
    public var scheme = InfoAgreementViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let checkBoxTextButtonView = CheckBoxTextButtonView()
    private let actionButton = PrimaryButton()
    private let alternativeButton = GhostButton()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Initializer
    
    public init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    public func apply(theme: AppTheme) {
        scheme = InfoAgreementViewScheme(theme: theme)
        actionButton.apply(theme: theme)
        alternativeButton.apply(theme: theme)
    }
    
    public func add(view: UIView, at index: Int) {
        guard stackView.arrangedSubviews.count >= index else { return }
        stackView.insertArrangedSubview(view, at: index)
    }
    
    public func remove(view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        checkBoxTextButtonView.scheme = scheme.checkBoxTextButtonViewTheme
    }
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.addArrangedSubview(checkBoxTextButtonView)
        stackView.addArrangedSubview(actionButton)
        stackView.addArrangedSubview(alternativeButton)
        
        updateItems()
    }
    
    private func updateItems() {
        checkBoxTextButtonView.isHidden = checkboxText == nil && checkboxButtonText == nil
        actionButton.isHidden = actionText == nil
        alternativeButton.isHidden = alternativeText == nil
    }
    
    private func configureLayout() {
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: 96.0)
        heightConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            heightConstraint
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        checkBoxTextButtonView.delegate = self
        
        apply(theme: defaultTheme)
    }
    
}

// MARK: - CheckBoxTextButtonViewDelegate

extension InfoAgreementView: CheckBoxTextButtonViewDelegate {
    
    public func checkBoxShouldSelected(_ checkBox: CheckBox) -> Bool {
        return delegate?.checkBoxShouldSelected(checkBox) ?? false
    }
    
}
