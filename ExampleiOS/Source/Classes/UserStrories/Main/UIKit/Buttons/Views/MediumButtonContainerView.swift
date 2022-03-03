//
//  MediumButtonContainerView.swift
//  ExampleiOS
//
//  Created on 16.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit
 
final class MediumButtonContainerView<T>: UIView, AnyAppThemable where T: UIControl {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            button.isEnabled = isEnabled
        }
    }
    
    // MARK: - Private Properties

    private var button: UIControl
    
    // MARK: - Initializer

    init(button: UIControl) {
        self.button = button
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic.uiColor
        if let button = button as? AppThemeCompatible {
            button.apply(theme: theme)
        }
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        setupConstraits()
    }
    
    private func addSubviews() {
        [button].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: LayoutGrid.halfModule * 15),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6)
        ])
    }
    
}
