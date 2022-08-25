//
//  SmallInformerView.swift
//  ExampleiOS
//
//  Created on 27.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct SmallInformerViewItem {
    let headLine: String
    let title: String
    let style: InformerStyle
    let cornerRadius: CornerRadius

    init(
        headLine: String,
        title: String,
        style: InformerStyle,
        cornerRadius: CornerRadius = .module
    ) {
        self.headLine = headLine
        self.title = title
        self.style = style
        self.cornerRadius = cornerRadius
    }
}

final class SmallInformerView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var scheme = InformersViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let informerView = SmallInformer()
    
    // MARK: - Initilizers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AppThemable
    
    func apply(theme: AppTheme) {
        scheme = InformersViewScheme(theme: theme)
        informerView.apply(theme: theme)
    }
    
    // MARK: - Public Methods
    
    func configureWith(model: SmallInformerViewItem) {
        informerView.titleText = model.title
        informerView.style = model.style
        titleLabel.text = model.headLine
        informerView.informerCornerRadius = model.cornerRadius
    }
    
    func setInformerState(isEnabled: Bool) {
        informerView.isEnabled = isEnabled
    }
    
    func setInformerArrowDirecdtion(direction: SmallInformerArrowDirection) {
        informerView.setArrowDirection(direction: direction)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        setupLabels()
        configureConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, informerView].addToSuperview(self)
    }

    private func setupLabels() {
        titleLabel.textAlignment = .left
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module * 2),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            informerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            informerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            informerView.heightAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.halfModule * 7),
            bottomAnchor.constraint(equalTo: informerView.bottomAnchor)
        ])
    }
 
}
