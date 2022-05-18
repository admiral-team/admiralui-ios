//
//  StaticNotificationView.swift
//  ExampleiOS
//
//  Created on 24.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct StaticNotificationViewModel {
    let title: String
    let text: String
    let linkText: String
    let type: ToastViewType
    let imageType: ToastImageType
    var linkAction: () -> Void = {}
    var closeAction: () -> Void = {}
}

final class StaticNotificationView: UIView, AnyAppThemable, AccessibilitySupport {
    
    var scheme = InformersViewScheme() {
        didSet { updateScheme() }
    }
    
    var isEnabled: Bool = true {
        didSet {
            toastView.isEnabled = isEnabled
            defaultToastView.isEnabled = isEnabled
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let headerLabel = UILabel()
    private let toastView = ToastView()
    private let defaultToastView = ToastView()
    
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
    
    func configureWith(model: StaticNotificationViewModel) {
        headerLabel.text = model.title
        
        toastView.title = model.text
        toastView.linkText = model.linkText
        toastView.type = model.type
        toastView.imageType = model.imageType
        toastView.linkAction = model.linkAction
        toastView.closeAction = model.closeAction
        
        defaultToastView.title = model.text
        defaultToastView.linkText = model.linkText
        defaultToastView.imageType = model.imageType
        defaultToastView.linkAction = model.linkAction
        defaultToastView.closeAction = model.closeAction
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        toastView.apply(theme: theme)
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
        [headerLabel, defaultToastView, toastView].addToSuperview(self)
    }
    
    private func setupViews() {
        defaultToastView.type = .default
    }
    
    private func setupLabels() {
        headerLabel.textAlignment = .left
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module * 2),
            trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            headerLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            
            defaultToastView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            defaultToastView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            trailingAnchor.constraint(equalTo: defaultToastView.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            toastView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            toastView.topAnchor.constraint(equalTo: defaultToastView.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        headerLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        headerLabel.textColor = scheme.textColor.uiColor
    }
 
}
