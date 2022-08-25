//
//  TabsView.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TabsView<T>: UIView, AnyAppThemable, AccessibilitySupport where T: UIControl {
    
    // MARK: - Public Properties
    
    public var isEnabled: Bool = true {
        didSet {
            segmentView.isEnabled = isEnabled
        }
    }

    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private var segmentView: UIControl
    private var segmentOffset: CGFloat
    
    private var scheme = TabsViewCustomScheme() {
        didSet { updateScheme() }
    }
    // MARK: - Initializer

    init(
        segmentView: T,
        title: String,
        segmentOffset: CGFloat = LayoutGrid.doubleModule
    ) {
        titleLabel.text = title
        self.segmentView = segmentView
        self.segmentOffset = segmentOffset
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        (segmentView as? AppThemeCompatible)?.apply(theme: theme)
        scheme = TabsViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureLabel()
        setupConstraits()
    }
    
    private func addSubviews() {
        [titleLabel,
         segmentView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }

    private func configureLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            
            segmentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            segmentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: segmentOffset),
            bottomAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: segmentView.trailingAnchor, constant: segmentOffset)
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
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
