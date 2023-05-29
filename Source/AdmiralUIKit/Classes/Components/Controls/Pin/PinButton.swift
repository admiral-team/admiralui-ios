//
//  PinButton.swift
//  AdmiralUIKit
//
//  Created on 17.02.2022.
//

import UIKit
import AdmiralTheme
/**
 The style for creating the Pin Button. Pin Button - tеhe component displays the position of the object on the map, exists in two states: Default and Selected. It is also possible to change the company logo inside the component or install an icon.

 You can create a PinButtonStyle by specifying the following parameters in the initializer

 - image - value of UIImage. The image is used to set the icon of the element
 - isSelected - Bool. Observable property for displaying the selected checkbox

 ## Example to create :
 # Code
 ```
let button = PinButton()
button.isSelected = true
 ```
 */
open class PinButton: CustomButton, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        /// Front layer properties.
        static let size = CGSize(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let cornerRadius: CGFloat = 18

        /// Main layer properties.
        static let backgroundLayerPosition: CGPoint = CGPoint(x: 18, y: 18)
        static let backgroundLayerSize = CGSize(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
        static let backgroundCornerRadius: CGFloat = LayoutGrid.halfModule * 3
    }

    // MARK: - Public Properties

    /// An image of PinButton.
    public var image: UIImage? {
        didSet {
            setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    /// The selection mark of PinButton.
    public override var isSelected: Bool {
        didSet {
            updateSchemeColors()
        }
    }

    /// The content size of PinButton.
    public override var intrinsicContentSize: CGSize {
        Constants.size
    }

    /// Color scheme.
    public var scheme = PinButtonScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private Properties

    private var layerBackgroundColor = ControlParameter<UIColor>()
    private var layerCornerRadius = ControlParameter<CGFloat>()

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Public Methods

    public func apply(theme: AppTheme) {
        scheme = PinButtonScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        setCornerRadius(Constants.backgroundCornerRadius, for: .normal)
    }

    private func setupUI() {
        setBackgroundLayerColor(isSelected ? scheme.frontColor.uiColor : UIColor.clear)
        backgroundLayer.frame.size = Constants.backgroundLayerSize
        backgroundLayer.position = Constants.backgroundLayerPosition
        layer.cornerRadius = Constants.cornerRadius
        imageView?.contentMode = .scaleAspectFit
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageEdgeInsets = Constants.edgeInsets
    }

    private func updateScheme() {
        updateSchemeColors()
    }

    private func updateSchemeColors() {
        let backgroundLayerColor = isSelected ? scheme.frontColor.uiColor : UIColor.clear
        setBackgroundColor(scheme.backgroundColor.uiColor, for: .normal)
        setBackgroundColor(scheme.selectedBackgroundColor.uiColor, for: .highlighted)
        setBackgroundColor(scheme.selectedBackgroundColor.uiColor, for: .selected)
        setBackgroundColor(scheme.disabledBackgroundColor.uiColor, for: .disabled)

        setBackgroundLayerColor(backgroundLayerColor, for: .normal)
        setBackgroundLayerColor(backgroundLayerColor, for: .selected)
        setBackgroundLayerColor(backgroundLayerColor, for: .highlighted)
        setBackgroundLayerColor(backgroundLayerColor, for: .disabled)

        setLayerCornerRadius(Constants.cornerRadius, for: .normal)
        setLayerCornerRadius(Constants.cornerRadius, for: .highlighted)
        setLayerCornerRadius(Constants.cornerRadius, for: .selected)
        setLayerCornerRadius(Constants.cornerRadius, for: .disabled)

        setShadowColor(scheme.shadowColor.uiColor, for: .normal)
        setShadowColor(scheme.shadowColor.uiColor, for: .selected)
        setShadowColor(scheme.shadowColor.uiColor, for: .highlighted)
        setShadowColor(scheme.shadowColor.uiColor, for: .disabled)

        setTintColor(scheme.buttonImageColor.uiColor, for: .normal)
        setTintColor(scheme.buttonImageColor.uiColor, for: .disabled)
        setTintColor(scheme.buttonImageColor.uiColor, for: .selected)
        setTintColor(scheme.buttonImageColor.uiColor, for: .highlighted)
    }

    // MARK: - Overridden methods

    open override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    open override func insertBackgroundLayer() {
        layer.insertSublayer(backgroundLayer, below: imageView?.layer)
    }

    override func configure(for state: UIControl.State) {
        layer.backgroundColor = layerBackgroundColor(for: state)?.cgColor
        layer.cornerRadius = layerCornerRadius(for: state)

        backgroundLayer.backgroundColor = backgroundColor(for: state)?.cgColor
        backgroundLayer.shadowColor = shadowColor(for: state)?.cgColor
        backgroundLayer.borderColor = borderColor(for: state)?.cgColor
        backgroundLayer.cornerRadius = cornerRadius(for: state)
        backgroundLayer.borderWidth = borderWidth(for: state)
        backgroundLayer.shadowRadius = shadowRadius(for: state)
        backgroundLayer.shadowOffset = shadowOffset(for: state)
        backgroundLayer.shadowOpacity = Float(shadowOpacity(for: state))
        backgroundLayer.shadowPath = shadowPath(for: state)

        tintColor = tintColor(for: state)
        configureAttributedTitle(for: state)
    }

}

// MARK: - Background layer configuration methods.
extension PinButton {

    /// Sets the layer background color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The background color to use for the specified state.
    ///   - states: The states that uses the specified background color. The possible values are described in UIControl.State.
    func setBackgroundLayerColor(_ color: UIColor?, for state: UIControl.State) {
        layerBackgroundColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    /// Returns the layer corner radius associated with the specified state.
    ///
    /// - Parameter state: The state that uses the corner radius. The possible values are described in UIControl.State.
    /// - Returns: The corner radius to use for the specified state.
    func layerCornerRadius(for state: UIControl.State) -> CGFloat {
        return layerCornerRadius.parameter(for: state) ?? 0
    }

    /// Returns the background color associated with the specified state.
    ///
    /// - Parameter state: The state that uses the background color. The possible values are described in UIControl.State.
    /// - Returns: The background color to use for the specified state.
    func layerBackgroundColor(for state: UIControl.State) -> UIColor? {
        return layerBackgroundColor.parameter(for: state)
    }

    /// Sets the corner radius for layer to use for the specified states.
    ///
    /// - Parameters:
    ///   - radius: The corner radius to use for the specified state.
    ///   - states: The states that uses the specified corner radius. The possible values are described in UIControl.State.
    func setLayerCornerRadius(_ radius: CGFloat, for state: UIControl.State) {
        layerCornerRadius.set(parameter: radius, for: state)
        updateIfNeeded(for: state)
    }

}
