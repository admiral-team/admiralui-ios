//
//  MapButton.swift
//  AdmiralUIKit
//
//  Created on 18.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The MapButton type.
public enum MapButtonType {
    /// The plus button type.
    case plus
    /// The minus button type.
    case minus
    /// The location button type.
    case location
    /// The custom button type with image.
    case custom(image: UIImage)
}
/**
 The style for creating the Map Button. The presented style is used to create buttons on the map

 You can create a MapButton by specifying the following parameters in the initializer

 - type - MapButtonType?. The image style of MapButton.

 ## Example to create button with MapButton:
 # Code
 ```
 let button = MapButton()
 button.type = .plus
 ```
*/
open class MapButton: CustomButton, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let size = CGSize(width: LayoutGrid.module * 5, height: LayoutGrid.module * 5)
        static let cornerRadius: CGFloat = LayoutGrid.halfModule * 5
    }

    // MARK: - Public Properties

    public var type: MapButtonType? {
        didSet {
            setImageButton()
        }
    }

    /// Color scheme.
    public var scheme = MapButtonScheme() {
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
        Constants.size
    }

    open override func insertBackgroundLayer() {
        layer.insertSublayer(backgroundLayer, below: imageView?.layer)
    }

    // MARK: - AnyAppThemable

    open func apply(theme: AppTheme) {
        scheme = MapButtonScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        setCornerRadius(Constants.cornerRadius, for: .normal)
        setCornerRadius(Constants.cornerRadius, for: .disabled)
        setCornerRadius(Constants.cornerRadius, for: .highlighted)
        setCornerRadius(Constants.cornerRadius, for: .selected)
    }

    private func updateScheme() {
        updateSchemeColors()
    }

    private func setImageButton() {
        switch type {
        case .plus:
            setImage(Asset.Service.Outline.plusOutline.image, for: .normal)
        case .minus:
            setImage(Asset.Service.Outline.minusOutline.image, for: .normal)
        case .location:
            setImage(Asset.Location.Solid.gpsSolid.image, for: .normal)
        case .custom(let image):
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        default:
            break
        }
    }

    private func updateSchemeColors() {
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .normal)
        setBackgroundColor(scheme.selectedBacgroundColor.uiColor, for: .highlighted)
        setBackgroundColor(scheme.selectedBacgroundColor.uiColor, for: .selected)
        setBackgroundColor(scheme.disabledBacgroundColor.uiColor, for: .disabled)

        setShadowColor(scheme.shadowColor.uiColor, for: .normal)
        setShadowColor(scheme.shadowColor.uiColor, for: .selected)
        setShadowColor(scheme.shadowColor.uiColor, for: .highlighted)
        setShadowColor(scheme.shadowColor.uiColor, for: .disabled)

        setTintColor(scheme.imageTintColor.uiColor, for: .normal)
        setTintColor(scheme.imageTintColor.uiColor, for: .selected)
        setTintColor(scheme.imageTintColor.uiColor, for: .highlighted)
        setTintColor(scheme.imageTintColor.uiColor, for: .disabled)
    }

}
