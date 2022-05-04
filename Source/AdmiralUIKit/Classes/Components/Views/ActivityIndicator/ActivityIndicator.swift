//
//  ActivityIndicator.swift
//  AdmiralUI
//
//  Created on 16.10.2020.
//

import UIKit
import AdmiralTheme

/// A view that shows that a task is in progress.
public class ActivityIndicator: UIView, AnyAppThemable {
    
    /// Activity indicator style.
    public enum Style {
        /// Default style.
        case `default`
        /// Contrast content style.
        case contrast
    }
    
    /// Activity indicator size.
    public enum Size: Int {
        /// Small size.
        case small
        /// Medium size.
        case medium
        /// Large size.
        case large
    }
    
    /// The control style.
    open var style: Style = .default {
        didSet { updateColors() }
    }
    
    /// The control size.
    open var size: Size = .medium {
        didSet {
            updateUI()
        }
    }

    /// This property indicates indicator state.
    public private(set) var isAnimating = false
    
    // MARK: - Internal Properties
    
    var scheme = ActivityIndicatorScheme() {
        didSet { updateColors() }
    }
    
    // MARK: - Private Properties

    private let indicator = CAShapeLayer()
    private let animator = ActivityIndicatorAnimator()

    private var lineWidth: CGFloat = 2.0 {
        didSet {
            indicator.lineWidth = self.lineWidth
            setNeedsLayout()
        }
    }

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        scheme = ActivityIndicatorScheme(theme: theme)
    }
    
    // MARK: - Private methods

    private func commonInit() {
        apply(theme: defaultTheme)
        
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        indicator.lineCap = .round
        
        layer.addSublayer(indicator)
        updateColors()
    }

    private func updateUI() {
        updateLineWidth()
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func updateColors() {
        switch self.style {
        case .default:
            indicator.strokeColor = scheme.defaultColor.cgColor
        case .contrast:
            indicator.strokeColor = scheme.contrastColor.cgColor
        }
    }

    private func updateLineWidth() {
        switch size {
        case .large:
            indicator.lineWidth = LayoutGrid.module / 2
        case .medium:
            indicator.lineWidth = LayoutGrid.tripleModule / 8
        case .small:
            indicator.lineWidth = LayoutGrid.doubleModule / 8
        }
    }
    
}

extension ActivityIndicator {

    /// The natural size for the receiving view, considering only properties of the view itself.
    override public var intrinsicContentSize: CGSize {
        switch size {
        case .small:
            return CGSize(
                width: LayoutGrid.doubleModule,
                height: LayoutGrid.doubleModule
            )
        case .medium:
            return CGSize(
                width: LayoutGrid.tripleModule,
                height: LayoutGrid.tripleModule
            )
        case .large:
            return CGSize(
                width: LayoutGrid.doubleModule * 3,
                height: LayoutGrid.doubleModule * 3
            )
        }
    }

    /// Lays out subviews.
    override public func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = bounds

        let diameter = min(bounds.size.width, bounds.size.height) - indicator.lineWidth
        let path = UIBezierPath(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: diameter / 2)
        
        indicator.path = path.cgPath
    }

}

extension ActivityIndicator {

    /// Start activity indicator animation.
    public func startAnimating() {
        guard !isAnimating else { return }

        animator.addAnimation(to: indicator)
        isAnimating = true
    }

    /// Stop activity indicator animation.
    public func stopAnimating() {
        guard isAnimating else { return }

        animator.removeAnimation(from: indicator)
        isAnimating = false
    }

}

private extension UIBezierPath {

    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }

}
