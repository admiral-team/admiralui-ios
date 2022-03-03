//
//  CircleLoader.swift
//  AdmiralUIKit
//
//  Created on 23.01.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit
/**
 CircularTrackView - the component that used for showing view with center loading indicator.

 You can create a CircularTrackView with the zero frame rectangle by specifying the following parameters in init:

 - style: ProgressViewStyle - The style of progress spinner.
 - isAnimating - The flag that controls animation.
 ## Example to create ProgressView
 # Code
 ```
 let trackView = CircularTrackView()
 trackView.style = .accent
 trackView.isAnimating = true
```
 */
/// A view with center loading indicator.
public class CircularTrackView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let lineWidth: CGFloat = 2.0
        static let alpha: CGFloat = 0.4
    }

    // MARK: - Private properties

    private let indicator = CAShapeLayer()
    private let animator = CircleLoaderAnimator()
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        if #available(iOS 12.0, *) {
            gradientLayer.type = .conic
        }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()

    private var lineWidth: CGFloat = Constants.lineWidth {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    // MARK: - Public properties

    public var isAnimating = false {
        didSet {
            if isAnimating {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }

    // MARK: - Internal properties

    /// The control style.
    open var style: ProgressViewStyle = .default {
        didSet { updateColors() }
    }

    var scheme = CircularTrackViewScheme() {
        didSet { updateColors() }
    }

    // MARK: - Initializer

    convenience init() {
        self.init(frame: .zero)
        self.commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public func apply(theme: AppTheme) {
        self.scheme = CircularTrackViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        apply(theme: defaultTheme)

        isHidden = true
        gradientLayer.frame = bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - Constants.lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

        indicator.fillColor = UIColor.clear.cgColor
        indicator.strokeColor = scheme.strokeColor.uiColor.cgColor
        indicator.lineWidth = Constants.lineWidth
        indicator.path = path.cgPath

        gradientLayer.mask = indicator
        layer.addSublayer(gradientLayer)
        updateColors()
    }

    private func updateUI() {
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func updateColors() {
        guard let circleColor = scheme.circleColor.parameter(style: style) else { return }

        gradientLayer.colors = [circleColor.withAlpha(Constants.alpha), circleColor].map { $0.cgColor }
        indicator.strokeColor = scheme.circleColor.parameter(style: style)?.cgColor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = bounds
        gradientLayer.frame = bounds

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - Constants.lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        indicator.path = path.cgPath
    }

}

private extension CircularTrackView {

    func startAnimating() {
         isHidden = false
         animator.addAnimation(to: gradientLayer)
     }
    
    func stopAnimating() {
         isHidden = true
         animator.removeAnimation(from: gradientLayer)
     }

 }
