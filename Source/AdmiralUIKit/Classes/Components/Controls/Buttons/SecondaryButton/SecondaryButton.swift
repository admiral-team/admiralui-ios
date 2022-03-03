//
//  SecondaryButton.swift
//  AdmiralUI
//
//  Created on 14.10.2020.
//

import UIKit
import AdmiralTheme

/// Secondary button. Used for additional actions. It can be used as a stand-alone button or paired with a transparent button.
open class SecondaryButton: CustomButton, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    public var scheme = SecondaryButtonCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = SecondaryButtonCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        setBorderWidth(2.0, for: .normal)
        setCornerRadius(LayoutGrid.module, for: .normal)
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        setTitleColor(scheme.normalTextColor.uiColor, for: .normal)
        setTitleColor(scheme.borderHightlightedColor.uiColor, for: .highlighted)
        setTitleColor(scheme.disabledTextColor.uiColor, for: .disabled)
        
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .normal)
        
        setBorderColor(scheme.borderNormalColor.uiColor, for: .normal)
        setBorderColor(scheme.borderHightlightedColor.uiColor, for: .highlighted)
        setBorderColor(scheme.borderDisabledColor.uiColor, for: .disabled)
    }
    
    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}
