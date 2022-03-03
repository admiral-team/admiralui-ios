//
//  CheckBoxTextButtonView.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme

public protocol CheckBoxTextButtonViewDelegate: AnyObject {
    func checkBoxShouldSelected(_ checkBox: CheckBox) -> Bool
}

/// A view object with checkBox view and button.
class CheckBoxTextButtonView: UIView, AnyAppThemable {
    
    /// Delegate CheckBoxTextButtonView.
    public weak var delegate: CheckBoxTextButtonViewDelegate?
    
    /// Text for check box.
    public var text: String? {
        didSet { сheckTextControl.text = text }
    }
    
    /// A Boolean value indicating whether the checkbox selected.
    public var isSelected: Bool = false {
        didSet { checkBox.isSelected = isSelected }
    }
    
    /// A Boolean value indicating whether the checkboxTextButtonView isEnabled.
    public var isEnabled: Bool = true {
        didSet {
            checkBox.isEnabled = isEnabled
            сheckTextControl.isEnabled = isEnabled
            linkButton.isEnabled = isEnabled
        }
    }
    
    /// Text for buttom botton checkbox.
    public var checkboxButtonText: String? {
        didSet { linkButton.setTitle(checkboxButtonText) }
    }
    
    // MARK: Internal Properties
    
    var scheme = CheckBoxTextButtonViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties

    private let checkBox = CheckBox()
    private lazy var сheckTextControl: CheckTextControl<CheckBox> = {
        return CheckTextControl<CheckBox>(checkControl: CheckBox())
    }()
    private let linkButton = PrimaryLinkControl()

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
        scheme = CheckBoxTextButtonViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor
        сheckTextControl.scheme = scheme.checkTextControl
        linkButton.scheme = scheme.primaryLinkScheme
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [сheckTextControl, linkButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            сheckTextControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            сheckTextControl.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.tripleModule),
            trailingAnchor.constraint(equalTo: сheckTextControl.trailingAnchor),
            
            linkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module * 3),
            linkButton.topAnchor.constraint(equalTo: сheckTextControl.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            trailingAnchor.constraint(equalTo: linkButton.trailingAnchor),
            bottomAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    private func configureUI() {
        linkButton.style = .none
        linkButton.fontStyle = .body
        
        сheckTextControl.addTarget(self, action: #selector(changeCheckBox(checkBox:)), for: .touchUpInside)
        
        apply(theme: defaultTheme)
    }
    
    @objc private func changeCheckBox(checkBox: CheckBox) {
        guard let isSelected = delegate?.checkBoxShouldSelected(checkBox) else { return }
        
        checkBox.isSelected = isSelected
    }
    
}
