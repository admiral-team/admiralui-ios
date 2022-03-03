//
//  StandardSegmentedView.swift
//  AdmiralUI
//
//  Created on 28.10.2020.
//

import UIKit
import AdmiralTheme

final class StandardSegmentedView: UIControl, SegmentControlItem, AccessibilitySupport {
     
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
        
    // MARK: - Internal Properties
    
    override var isSelected: Bool {
        didSet { updateScheme()  }
    }
    
    override var isHighlighted: Bool {
        didSet { updateScheme()  }
    }
    
    override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    var title: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    var isSeparatorHidden: Bool {
        get { return separatorView.isHidden }
        set { separatorView.isHidden = newValue }
    }
    
    var scheme = StandardSegmentedScheme() {
        didSet { updateScheme() }
    }
        
    // MARK: - Private Properties
    
    private let label = UILabel()
    private let separatorView = UIView()
        
    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        [label, separatorView].addToSuperview(self)
        
        NSLayoutConstraint.activate(label.fillView(view: self)
        + [trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
           separatorView.widthAnchor.constraint(equalToConstant: 1.0),
           separatorView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
           separatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        configureUI()        
    }
    
    private func configureUI() {
        label.textAlignment = .center
        updateScheme()
    }
    
    private func configure() {
        if let font = scheme.itemScheme.titleFont.parameter(for: state) {
            label.setDynamicFont(
                font: font.uiFont,
                textStyle: font.textStyle,
                adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        }
      
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        if let font = scheme.itemScheme.titleFont.parameter(for: state) {
            label.setDynamicFont(
                font: font.uiFont,
                textStyle: font.textStyle,
                adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        }
    }
    
    private func updateSchemeColors() {
        label.textColor = scheme.itemScheme.titleColor.parameter(for: state)?.uiColor
        separatorView.backgroundColor = scheme.borderColor.parameter(for: state)?.uiColor
    }
    
}
