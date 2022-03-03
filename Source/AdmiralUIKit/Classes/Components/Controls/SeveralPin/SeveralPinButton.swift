//
//  SeveralPinButton.swift
//  AdmiralUIResources
//
//  Created on 17.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The frame size of SeveralPinButton.
public enum SeveralPinButtonSize {
    /// The small size.
    case small
    /// The medium size.
    case medium
    /// The large size.
    case large
}
/**
 The style for creating the Several Pin Button. Several Pin Button - the component displays the position of several objects on the map at one point, exists in three sizes: Small, Medium and Big - use the appropriate one depending on the number of characters.

 You can create a SeveralPinButtonStyle by specifying the following parameters in the initializer

 - style - the size. The image is used to set the icon of the element

 ## Example to create :
 # Code
 ```
let button = SeveralPinButton()
button.style = .medium
 ```
 */
open class SeveralPinButton: CustomButton, AnyAppThemable, AccessibilitySupport {

    // MARK: - Public Properties

    public var style: SeveralPinButtonSize = .medium {
        didSet {
            updateScheme()
        }
    }

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    public override var intrinsicContentSize: CGSize {
        size
    }

    // MARK: - Private Properties

    private var cornerRadius: CGFloat {
        switch style {
        case .small:
            return LayoutGrid.halfModule * 3
        case .large:
            return LayoutGrid.halfModule * 5
        case .medium:
            return LayoutGrid.doubleModule
        }
    }

    private var size: CGSize {
        switch style {
        case .small:
            return CGSize(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
        case .large:
            return CGSize(width: LayoutGrid.module * 5, height: LayoutGrid.module * 5)
        case .medium:
            return CGSize(width: LayoutGrid.halfModule * 8, height: LayoutGrid.halfModule * 8)
        }
    }

    // MARK: - Internal Properties

    var scheme = SeveralPinButtonScheme() {
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

    // MARK: - AnyAppThemable

    open func apply(theme: AppTheme) {
        scheme = SeveralPinButtonScheme(theme: theme)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(cornerRadius, for: .normal)
        setCornerRadius(cornerRadius, for: .disabled)
        setCornerRadius(cornerRadius, for: .highlighted)
        setCornerRadius(cornerRadius, for: .selected)
    }

    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        setBorderWidth(LayoutGrid.halfModule / 2, for: .normal)
    }

    private func updateScheme() {
        updateSchemeColors()
        updateSchemeFonts()
    }

    private func updateSchemeColors() {
        setTitleColor(scheme.textColor.uiColor, for: .normal)
        setTitleColor(scheme.disabledColor.uiColor, for: .disabled)
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .normal)
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .selected)
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .highlighted)
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .disabled)

        setBorderColor(scheme.borderColor.uiColor, for: .normal)
        setBorderColor(scheme.borderColorPressed.uiColor, for: .highlighted)
        setBorderColor(scheme.borderColorPressed.uiColor, for: .selected)
        setBorderColor(scheme.borderColorDisabled.uiColor, for: .disabled)

        setShadowColor(scheme.shadowColor.uiColor, for: .normal)
        setShadowColor(scheme.shadowColor.uiColor, for: .selected)
        setShadowColor(scheme.shadowColor.uiColor, for: .highlighted)
        setShadowColor(scheme.shadowColor.uiColor, for: .disabled)
    }

    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.font.uiFont,
            textStyle: scheme.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
