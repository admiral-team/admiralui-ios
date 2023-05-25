//
//  ChatButton.swift
//  AdmiralUIKit
//
//  Created on 25.11.2021.
//

import UIKit
import AdmiralTheme

open class ChatButton: CustomButton, AnyAppThemable, AccessibilitySupport {

    // MARK: - Public Properties

    public var scheme = ChatButtonCustomScheme() {
        didSet { updateScheme() }
    }

    public var image: UIImage? {
        didSet { setImage(oldValue, for: .normal) }
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

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: LayoutGrid.doubleModule * 3)
    }

    // MARK: - AnyAppThemable

    open func apply(theme: AppTheme) {
        scheme = ChatButtonCustomScheme(theme: theme)
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
        
        tintColor = scheme.normalTextColor.uiColor
        
        setBackgroundLayerColor(scheme.backgroundLayerColor.uiColor)
        setBackgroundColor(scheme.backgroundNormalColor.uiColor, for: .normal)
        setBackgroundColor(scheme.backgroundHightlightedColor.uiColor, for: .highlighted)
        setBackgroundColor(scheme.backgroundDisabledColor.uiColor, for: .disabled)
    }

    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}
