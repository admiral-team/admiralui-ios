//
//  CustomButton.swift
//  AdmiralUI
//
//  Created on 14.10.2020.
//

import UIKit
import AdmiralUIResources

/// The base button class with extended properties for UIControl.State.
open class CustomButton: UIButton {

    // MARK: - Override states

    /// A Boolean value indicating whether the control is in the selected state.
    open override var isSelected: Bool {
        didSet { configure(for: state) }
    }

    /// A Boolean value indicating whether the control draws a highlight.
    open override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            highlight() {
                super.isHighlighted = newValue
            }
            configure(for: state)
        }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    open override var isEnabled: Bool {
        didSet { configure(for: state) }
    }

    // MARK: - Public Properties

    /// A Boolean value indicating whether the control highlight animated.
    open var shouldAnimateHighlighting: Bool = true

    /// Highlight animation duration.
    open var animationDuration: TimeInterval = Durations.Default.single

    // MARK: - Internal Properties

    var backgroundLayer = CALayer()
    var backgroundLayerColor: UIColor?

    // MARK: - Private Properties

    private var buttonBackgroundColor = ControlParameter<UIColor>()
    private var buttonShadowColor = ControlParameter<UIColor>()
    private var buttonBorderColor = ControlParameter<UIColor>()
    private var buttonAttributeTitleColor = ControlParameter<UIColor>()
    private var buttonTintColor = ControlParameter<UIColor>()
    private var buttonCornerRadius = ControlParameter<CGFloat>()
    private var buttonBorderWidth = ControlParameter<CGFloat>()
    private var buttonShadowOpacity = ControlParameter<CGFloat>()
    private var buttonShadowRadius = ControlParameter<CGFloat>()
    private var buttonShadowOffset = ControlParameter<CGSize>()
    private var buttonShadowPath = ControlParameter<CGPath>()

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        insertBackgroundLayer()
        setImageLayer()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame.size = layer.frame.size
    }

    // MARK: - Set Colors

    open func setBackgroundLayerColor(_ color: UIColor?) {
        backgroundLayerColor = color
    }

    /// Sets the background color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The background color to use for the specified state.
    ///   - states: The states that uses the specified background color. The possible values are described in UIControl.State.
    open func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        buttonBackgroundColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the shadow color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The shadow color to use for the specified state.
    ///   - states: The states that uses the specified shadow color. The possible values are described in UIControl.State.
    open func setShadowColor(_ color: UIColor?, for state: UIControl.State) {
        buttonShadowColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the border color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The border color to use for the specified state.
    ///   - states: The states that uses the specified border color. The possible values are described in UIControl.State.
    open func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        buttonBorderColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the attributed title color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The attributed title color to use for the specified state.
    ///   - states: The states that uses the specified attributed title color. The possible values are described in UIControl.State.
    open func setAttributeTitleColor(_ color: UIColor?, for state: UIControl.State) {
        buttonAttributeTitleColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    // MARK: - Set Radius & Width

    /// Sets the corner radius to use for the specified states.
    ///
    /// - Parameters:
    ///   - radius: The corner radius to use for the specified state.
    ///   - states: The states that uses the specified corner radius. The possible values are described in UIControl.State.
    open func setCornerRadius(_ radius: CGFloat, for state: UIControl.State) {
        buttonCornerRadius.set(parameter: radius, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the border width to use for the specified states.
    ///
    /// - Parameters:
    ///   - width: The border width to use for the specified state.
    ///   - states: The states that uses the specified border width. The possible values are described in UIControl.State.
    open func setBorderWidth(_ width: CGFloat, for state: UIControl.State) {
        buttonBorderWidth.set(parameter: width, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the shadow opacity to use for the specified states.
    ///
    /// - Parameters:
    ///   - opacity: The shadow opacity to use for the specified state.
    ///   - states: The states that uses the specified shadow opacity. The possible values are described in UIControl.State.
    open func setShadowOpacity(_ opacity: CGFloat, for state: UIControl.State) {
        buttonShadowOpacity.set(parameter: opacity, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the shadow radius to use for the specified states.
    ///
    /// - Parameters:
    ///   - radius: The shadow radius to use for the specified state.
    ///   - states: The states that uses the specified shadow radius. The possible values are described in UIControl.State.
    open func setShadowRadius(_ radius: CGFloat, for state: UIControl.State) {
        buttonShadowRadius.set(parameter: radius, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the shadow offset to use for the specified states.
    ///
    /// - Parameters:
    ///   - offset: The shadow offset to use for the specified state.
    ///   - states: The states that uses the specified shadow offset. The possible values are described in UIControl.State.
    open func setShadowOffset(_ offset: CGSize, for state: UIControl.State) {
        buttonShadowOffset.set(parameter: offset, for: state)
        updateIfNeeded(for: state)
    }

    /// Sets the shadow path to use for the specified states.
    ///
    /// - Parameters:
    ///   - path: The shadow path to use for the specified state.
    ///   - states: The states that uses the specified shadow path. The possible values are described in UIControl.State.
    open func setShadowPath(_ path: CGPath, for state: UIControl.State) {
        buttonShadowPath.set(parameter: path, for: state)
        updateIfNeeded(for: state)
    }

    // MARK: - Set Title & Title Color & BackgroundImage

    /// Sets the tint color to use for the specified states.
    ///
    /// - Parameters:
    ///   - color: The tint color to use for the specified state.
    ///   - states: The states that uses the specified attributed title color. The possible values are described in UIControl.State.
    open func setTintColor(_ color: UIColor?, for state: UIControl.State) {
        buttonTintColor.set(parameter: color, for: state)
        updateIfNeeded(for: state)
    }

    // MARK: - Get Colors

    /// Returns the background color associated with the specified state.
    ///
    /// - Parameter state: The state that uses the background color. The possible values are described in UIControl.State.
    /// - Returns: The background color to use for the specified state.
    open func backgroundColor(for state: UIControl.State) -> UIColor? {
        return buttonBackgroundColor.parameter(for: state)
    }

    /// Returns the shadow color associated with the specified state.
    ///
    /// - Parameter state: The state that uses the shadow color. The possible values are described in UIControl.State.
    /// - Returns: The shadow color to use for the specified state.
    open func shadowColor(for state: UIControl.State) -> UIColor? {
        return buttonShadowColor.parameter(for: state)
    }

    /// Returns the border color associated with the specified state.
    ///
    /// - Parameter state: The state that uses the border color. The possible values are described in UIControl.State.
    /// - Returns: The border color to use for the specified state.
    open func borderColor(for state: UIControl.State) -> UIColor? {
        return buttonBorderColor.parameter(for: state)
    }

    /// Returns the attribute title color associated with the specified state.
    ///
    /// - Parameters state: The state that uses the attribute title. The possible values are described in UIControl.State.
    /// - Returns: The attribute title to use for the specified state.
    open func attributeTitleColor(for state: UIControl.State) -> UIColor? {
        return buttonAttributeTitleColor.parameter(for: state)
    }

    /// Returns the tint color associated with the specified state.
    ///
    /// - Parameters state: The state that uses the attribute title. The possible values are described in UIControl.State.
    /// - Returns: The tint color to use for the specified state.
    open func tintColor(for states: UIControl.State) -> UIColor {
        return buttonTintColor.parameter(for: state) ?? tintColor
    }

    // MARK: - Get Radius & Width

    /// Returns the corner radius associated with the specified state.
    ///
    /// - Parameter state: The state that uses the corner radius. The possible values are described in UIControl.State.
    /// - Returns: The corner radius to use for the specified state.
    open func cornerRadius(for state: UIControl.State) -> CGFloat {
        return buttonCornerRadius.parameter(for: state) ?? 0
    }

    /// Returns the border width associated with the specified state.
    ///
    /// - Parameter state: The state that uses the border width. The possible values are described in UIControl.State.
    /// - Returns: The border width to use for the specified state.
    open func borderWidth(for state: UIControl.State) -> CGFloat {
        return buttonBorderWidth.parameter(for: state) ?? 0
    }

    /// Returns the shadow opacity associated with the specified state.
    ///
    /// - Parameter state: The state that uses the shadow opacity. The possible values are described in UIControl.State.
    /// - Returns: The shadow opacity to use for the specified state.
    open func shadowOpacity(for state: UIControl.State) -> CGFloat {
        return buttonShadowOpacity.parameter(for: state) ?? 0
    }

    /// Returns the shadow radius associated with the specified state.
    ///
    /// - Parameter state: The state that uses the shadow radius. The possible values are described in UIControl.State.
    /// - Returns: The shadow radius to use for the specified state.
    open func shadowRadius(for state: UIControl.State) -> CGFloat {
        return buttonShadowRadius.parameter(for: state) ?? 0
    }

    /// Returns the shadow offset associated with the specified state.
    ///
    /// - Parameter state: The state that uses the shadow offset. The possible values are described in UIControl.State.
    /// - Returns: The shadow offset to use for the specified state.
    open func shadowOffset(for state: UIControl.State) -> CGSize {
        return buttonShadowOffset.parameter(for: state) ?? .zero
    }

    /// Returns the shadow path with the specified state.
    ///
    /// - Parameter state: The state that uses the shadow path. The possible values are described in UIControl.State.
    /// - Returns: The shadow path to use for the specified state.
    open func shadowPath(for state: UIControl.State) -> CGPath? {
        return buttonShadowPath.parameter(for: state)
    }

    // MARK: - Configuration Methods

    func configure(for state: UIControl.State) {
        layer.backgroundColor = backgroundLayerColor?.cgColor
        layer.cornerRadius = cornerRadius(for: state)

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

    func configureAttributedTitle(for state: UIControl.State) {
        guard
            let color = buttonAttributeTitleColor.parameter(for: state),
            let attributedTitle = attributedTitle(for: state)
        else { return }

        let attributes = [NSAttributedString.Key.foregroundColor: color]
        setAttributedTitle(NSAttributedString(string: attributedTitle.string, attributes: attributes), for: state)
    }

    func updateIfNeeded(for newState: UIControl.State) {
        guard newState.contains(state) else { return }
        configure(for: state)
    }

    func highlight(animation: @escaping () -> Void) {
        guard shouldAnimateHighlighting else {
            animation()
            return
        }

        UIView.transition(
            with: self,
            duration: animationDuration,
            options: [.transitionCrossDissolve, .allowAnimatedContent, .allowUserInteraction],
            animations: animation,
            completion: nil)
    }

    func insertBackgroundLayer() {
        layer.addSublayer(backgroundLayer)
    }

    func setImageLayer() {
        imageView?.layer.zPosition = 1
    }

}
