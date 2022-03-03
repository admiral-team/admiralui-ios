//
//  ShimmeringView.swift
//  AdmiralUI
//
//  Created on 16.12.2020.
//

import UIKit
import AdmiralTheme

/// Shimmering View
final public class ShimmeringView: UIView, AnyAppThemable {

    // MARK: - Public Properties
    
    override public class var layerClass: Swift.AnyClass {
        return ShimmeringLayer.self
    }
    
    /// The content view to be shimmered
    public var contentView = UIView() {
        didSet {
            if oldValue != contentView {
                addSubview(contentView)
                shimmerLayer?.contentLayer = contentView.layer
            }
        }
    }
    
    // MARK: - Internal Properties
    
    /// The time interval shimmers in seconds.
    /// Defaults to 1.5.
    public var shimmerTime: Double = 1.5 {
        didSet { shimmerLayer?.shimmerTime = shimmerTime }
    }

    /// The highlight length of the shimmer. Range of [0,1], defaults to 1.0.
    public var shimmerHighlightLength: CGFloat = 1.0 {
        didSet { shimmerLayer?.shimmerHighlightLength = shimmerHighlightLength }
    }

    /// The direction of the shimmer animation.
    /// Defaults to `.right`, which will run the animation from left to right.
    public var shimmerDirection: Shimmer.Direction = .right {
        didSet { shimmerLayer?.updateShimmering() }
    }

    /// The time interval between shimmers in seconds.
    /// Defaults to 1.4.
    public var shimmerPauseDuration: CFTimeInterval = 1.4 {
        didSet { shimmerLayer?.shimmerPauseDuration = shimmerPauseDuration }
    }

    /// The opacity of the content during a shimmer. Defaults to 0.5.
    public var shimmerAnimationOpacity: CGFloat = 1.0 {
        didSet { shimmerLayer?.shimmerAnimationOpacity = shimmerAnimationOpacity }
    }

    /// The opacity of the content when not shimmering. Defaults to 1.0.
    public var shimmerOpacity: CGFloat = 1.0 {
        didSet { shimmerLayer?.shimmerOpacity = shimmerOpacity }
    }

    /// The absolute CoreAnimation media time when the shimmer will begin.
    public var shimmerBeginTime: CFTimeInterval = .greatestFiniteMagnitude {
        didSet { shimmerLayer?.shimmerBeginTime = shimmerBeginTime }
    }

    /// The duration of the fade used when the shimmer begins. Defaults to 0.1.
    public var shimmerBeginFadeDuration: CFTimeInterval = 0.1 {
        didSet { shimmerLayer?.shimmerBeginFadeDuration = shimmerBeginFadeDuration }
    }

    /// The duration of the fade used when the shimmer ends. Defaults to 0.3.
    public var shimmerEndFadeDuration: CFTimeInterval = 0.3 {
        didSet { shimmerLayer?.shimmerEndFadeDuration = shimmerEndFadeDuration }
    }

    /// The absolute CoreAnimation media time when the shimmer will fade in.
    public var shimmerFadeTime: CFTimeInterval? {
        didSet { shimmerLayer?.shimmerFadeTime = shimmerFadeTime }
    }

    let defaultView = UIView()
    
    var scheme = ShimmeringViewColorScheme() {
        didSet { configure(for: state) }
    }
    
    var state: UIControl.State = .normal {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties
    
    private var shimmerLayer: ShimmeringLayer? {
        return (layer as? ShimmeringLayer)
    }
    
    // MARK: - Initializer

    override public func layoutSubviews() {
        contentView.bounds = bounds
        contentView.center = center
        super.layoutSubviews()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    
    /// Start shimmering.
    public func start() {
        shimmerLayer?.isShimmering = true
    }
    
    /// Finish shimmering.
    public func finish() {
        shimmerLayer?.isShimmering = false
    }
    
    public func apply(theme: AppTheme) {
        scheme = ShimmeringViewColorScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        contentView = defaultView
        apply(theme: defaultTheme)
    }
    
    private func configure(for state: UIControl.State) {
        guard defaultView == contentView else { return }
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }

}
