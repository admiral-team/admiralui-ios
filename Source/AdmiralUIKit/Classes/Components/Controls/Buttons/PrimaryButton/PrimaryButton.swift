//
//  PrimaryButton.swift
//  AdmiralUI
//
//  Created on 14.10.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// Main button. Used for the most important actions. It is advisable to use one such button on the screen.
open class PrimaryButton: CustomButton, AnyAppThemable, AccessibilitySupport {
   
    // MARK: - Public Properties
    
    public var scheme = PrimaryButtonCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = PrimaryButtonCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        setCornerRadius(LayoutGrid.module, for: .normal)
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        setTitleColor(scheme.normalTextColor.uiColor, for: .normal)
        setTitleColor(scheme.disabledTextColor.uiColor, for: .disabled)
        
        setBackgroundLayerColor(scheme.backgroundLayerColor.uiColor)
        
        setBackgroundColor(scheme.backgroundNormalColor.uiColor, for: .normal)
        setBackgroundColor(scheme.backgroundHightlightedColor.uiColor, for: .highlighted)
        setBackgroundColor(scheme.backgroundDisabledColor.uiColor, for: .disabled)
        
        tintColor = scheme.normalTextColor.uiColor
    }
    
    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}
