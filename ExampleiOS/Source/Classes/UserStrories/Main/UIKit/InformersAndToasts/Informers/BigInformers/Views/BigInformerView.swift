//
//  BigInformerView.swift
//  ExampleiOS
//
//  Created on 24.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct BigInformerViewViewModel {
    
    let headLine: String
    let title: String
    let description: String
    let linkLabel: String
    let style: InformerStyle
    
}

protocol Informer: AnyObject {
    var isEnabled: Bool { get set }
}

final class BigInformerView: UIView, Informer, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            informerView.isEnabled = isEnabled
        }
    }
    
    var scheme = InformersViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let informerView = BigInformer()
    
    // MARK: - Initilizers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    func configureWith(model: BigInformerViewViewModel) {
        informerView.titleText = model.title
        informerView.descriptionText = model.description
        informerView.linkText = model.linkLabel
        informerView.style = model.style
        titleLabel.text = model.headLine
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        informerView.apply(theme: theme)
        scheme = InformersViewScheme(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        setupLabels()
        setupViews()
        configureConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(informerView)
    }
    
    private func setupViews() {
        informerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module * 2),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            informerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            informerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: informerView.bottomAnchor, constant: LayoutGrid.doubleModule)
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
    }
 
}
