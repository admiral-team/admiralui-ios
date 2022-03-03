//
//  ButtonCellView.swift
//  Example iOS
//
//  Created by ADyatkov on 14.10.2020.
//

import UIKit
import AdmiralUI

final class ButtonCellView<T>: UIView, AnyAppThemable where T: UIControl, T: AppThemeCompatible {

    // MARK: - Private Properties
    
    private var button: T
    private let switchControl = CustomSwitch()
    private var switchAction: ((_ isOn: Bool) -> Void)?
    
    // MARK: - Initializer

    init(button: T, switchAction: ((_ isOn: Bool) -> Void)?) {
        self.button = button
        self.switchAction = switchAction
        super.init(frame: .zero)
        
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(theme: AppTheme) {
        backgroundColor = theme.colors.background.uicolor
        switchControl.apply(theme: theme)
        button.apply(theme: theme)
    }
    
    private func configureUI() {
        configureLayout()
        configureSwitch()
    }
    
    private func configureLayout() {
        let views = [switchControl, button]
        
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            switchControl.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            button.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: -8.0),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            button.heightAnchor.constraint(equalToConstant: 48.0),
            
            bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func configureSwitch() {
        switchControl.onTintColor = .blue60
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(changeSwitch(_:)), for: .valueChanged)
    }
    
    @objc private func changeSwitch(_ switchView: UISwitch) {
        switchAction?(switchView.isOn)
    }

}
