//
//  BadgeCellView.swift
//  Example iOS
//
//  Created on 19.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class BadgeCellView<T>: UIView, AnyAppThemable, AccessibilitySupport where T: Badge {

    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            badgeView.isEnabled = isEnabled
            inputTextField.isEnabled = isEnabled
        }
    }
    
    var scheme = BadgeCellViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let inputTextField = InputNumber()
    private let titleLabel = UILabel()
    private let badgeView: Badge
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let initialValue: Int?
    
    // MARK: - Initializer

    init(title: String, badgeView: T, initialValue: Int? = nil) {
        self.titleLabel.text = title
        self.badgeView = badgeView
        self.initialValue = initialValue
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.width / 2
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        inputTextField.apply(theme: theme)
        badgeView.apply(theme: theme)
        scheme = BadgeCellViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureInputTextField()
        configureBadgeView()
        configureLabel()
        setupConstraits()
        configureImageViews()
    }
    
    private func addSubviews() {
        [inputTextField,
         titleLabel,
         contentView,
         badgeView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        [imageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imageView)
        })
    }
    
    private func configureInputTextField() {
        inputTextField.value = 1
        inputTextField.minimumValue = 0
        inputTextField.maximumValue = 1000
        inputTextField.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    private func configureBadgeView() {
        guard let badgeValue = initialValue else {
            badgeView.text = nil
            return
        }
        badgeView.text = String(badgeValue)
    }
    
    private func configureImageViews() {
        imageView.image = Asset.Badges.diamondSolid.image.withRenderingMode(.alwaysTemplate)
    }
    
    private func configureLabel() {
        titleLabel.textAlignment = .left
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            badgeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule * 11),
            badgeView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: LayoutGrid.doubleModule * 2),

            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            contentView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24.0),
            imageView.heightAnchor.constraint(equalToConstant: 24.0),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 16)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
        contentView.backgroundColor = scheme.contentViewColor.uiColor
        imageView.tintColor = scheme.imageViewColor.uiColor
    }
    
    @objc private func stepperValueChanged(_ stepper: InputNumber) {
        guard initialValue != nil else {
            badgeView.text = nil
            return
        }
        badgeView.text = String(Int(stepper.value))
    }

}
