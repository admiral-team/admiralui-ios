//
//  PlatformButton.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 Main button. Used for the most important actions. It is advisable to use one such button on the screen.
 
 You can create a button with an activity indicator instead of text. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:
 
 You can add accessibilityIdentifier (a string that identifies the element) in PlatformButton
 
 # Code PlatformButton width image
 ```
 let button = PlatformButton()
     button.setTitle(name, for: .normal)
     button.setImage(image, for: .normal)
     button.setImage(image, for: .highlighted)
     button.semanticContentAttribute = .forceLeftToRight
     button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: LayoutGrid.doubleModule)
 ```
*/
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
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
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
