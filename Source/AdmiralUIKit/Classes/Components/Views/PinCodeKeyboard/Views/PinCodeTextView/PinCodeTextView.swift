//
//  PinCodeTextView.swift
//  AdmiralUIKit
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme

final public class PinCodeTextView: UIControl, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    public override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    public override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    public override var isHighlighted: Bool {
        didSet { updateScheme() }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var scheme = PinCodeTextViewCustomScheme() {
        didSet { updateScheme() }
    }
        
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()

    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = PinCodeTextViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupConstraints()
        configureUI()
    }
    
    private func addSubviews() {
        [titleLabel].addToSuperview(self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        updateScheme()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.font = scheme.textFont.uiFont
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
    }
    
}
