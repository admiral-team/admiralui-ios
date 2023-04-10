//
//  SecureTextField.swift
//  ExampleiOS
//
//  Created on 20.10.2020.
//

import AdmiralUIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

// Default description for your class
final class SecureTextField: UIView, AnyAppThemable {
    
    // MARK: - Public PropertOies
    
    let textField = TextField()
    let secureButton = UIButton()
    
    var state: TextInputState {
        get { textField.state }
        set {
            textField.state = newValue
            updateState()
        }
    }
    
    private var normalColor: AColor = AppTheme.default.colors.textPrimary
    private var disableColor: AColor = AppTheme.default.colors.textPrimary
        
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
        normalColor = theme.colors.textSecondary
        disableColor = theme.colors.textSecondary.withAlpha(alpha)
        textField.apply(theme: theme)
        updateState()
    }
    
    private func updateState() {
        let state = textField.state
        let isEnabled = state != .disabled && state != .readOnly
        secureButton.isEnabled = state != .disabled
        secureButton.tintColor = isEnabled ? normalColor.uiColor : disableColor.uiColor
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
        secureButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        secureButton.setImage(AdmiralUIResources.Asset.Service.Outline.eyeCloseOutline.image, for: .normal)
        secureButton.setImage(AdmiralUIResources.Asset.Service.Outline.eyeOutline.image, for: .selected)
        textField.trailingViewStyle = .small
        textField.trailingView = secureButton
    }
    
    @objc private func didTap() {
        secureButton.isSelected = !secureButton.isSelected
        textField.isSecureTextEntry = secureButton.isSelected
    }
    
}
