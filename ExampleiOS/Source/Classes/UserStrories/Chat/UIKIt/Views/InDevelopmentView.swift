//
//  InDevelopmentView.swift
//  ExampleiOS
//
//  Created on 05.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class InDevelopmentView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var scheme = InDevelopmentViewCustomScheme() {
        didSet { updateScheme() }
    }
    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = InDevelopmentViewCustomScheme(theme: theme)
    }
    
    private func commonInit() {
        addSubviews()
        setupContraints()
        setupLabels()
    }
    
    private func addSubviews() {
        [imageView,
         titleLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
         })
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }

    private func setupContraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 18),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 18),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
    }
    
}
