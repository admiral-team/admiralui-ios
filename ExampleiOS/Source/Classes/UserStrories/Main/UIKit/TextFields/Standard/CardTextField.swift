//
//  CardTextField.swift
//  ExampleiOS
//
//  Created on 11.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

// Default description for your class
final class CardTextField: UIView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var state: TextInputState {
        get { textField.state }
        set {
            textField.state = newValue
            updateState()
        }
    }
    
    let textField = BankCardTextField()
    let button = UIButton()
    
    // MARK: - Private properties
    
    private var normalColor: AColor = AppTheme.default.colors.backgroundBasic
    private var disableColor: AColor = AppTheme.default.colors.backgroundBasic
    
    // MARK: - Public Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        normalColor = theme.colors.elementAccent
        disableColor = theme.colors.textSecondary.withAlpha(alpha)
        textField.apply(theme: theme)
        updateState()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate(textField.fillView(view: self))
    }
    
    private func configureUI() {
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.setImage(AdmiralUIResources.Asset.Security.Outline.passwordOutline.image, for: .normal)
        textField.trailingView = button
    }
    
    private func updateState() {
        let state = textField.state
        let isEnabled = state != .disabled && state != .readOnly
        button.isEnabled = isEnabled
        button.tintColor = isEnabled ? normalColor.uiColor : disableColor.uiColor
    }
    
    @objc private func didTap() {
        //
    }
    
}
