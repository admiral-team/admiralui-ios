//
//  PlatformButton.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// Main button. Used for the most important actions. It is advisable to use one such button on the screen.
open class PlatformButton: CustomButton, AnyAppThemable, AccessibilitySupport {
   
    // MARK: - Public Properties
    
    public var scheme = PlatformButtonCustomScheme() {
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
        scheme = PlatformButtonCustomScheme(theme: theme)
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
        setTitleColor(scheme.textColor.parameter(for: .normal)?.uiColor, for: .normal)
        setTitleColor(scheme.textColor.parameter(for: .disabled)?.uiColor, for: .disabled)
        
        setBackgroundLayerColor(scheme.backgroundLayerColor.uiColor)
        
        setBackgroundColor(scheme.buttonBackgroundColor.parameter(for: .normal)?.uiColor, for: .normal)
        setBackgroundColor(scheme.buttonBackgroundColor.parameter(for: .highlighted)?.uiColor, for: .highlighted)
        setBackgroundColor(scheme.buttonBackgroundColor.parameter(for: .disabled)?.uiColor, for: .disabled)
    
    }
    
    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}
