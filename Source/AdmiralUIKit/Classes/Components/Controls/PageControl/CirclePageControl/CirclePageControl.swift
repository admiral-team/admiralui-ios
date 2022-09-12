//
//  CirclePageControl.swift
//  AdmiralUI
//
//  Created on 27.01.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public protocol CirclePageControlDelegate: AnyObject {
    func didTapCenterButton()
    func didChangePage(page: Int)
}

public extension CirclePageControlDelegate {
    func didTapCenterButton() {}
    func didChangePage(page: Int) {}
}

/// CirclePageControl to show pages progress in a circle
public class CirclePageControl: UIView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// CirclePageControl delegate
    public weak var delegate: CirclePageControlDelegate?
    
    /// The number of pages of page control
    public var totalPages: Int = 0
    
    /// The duration of page change
    public var duration: TimeInterval = 0.0
    
    /// The current page of page control
    public var currentPage: Int = 0 
    
    /// CirclePageControlScheme
    public var scheme = CirclePageControlScheme() {
        didSet {
            updateScheme()
        }
    }
    
    // MARK: - Private Properties
    
    private let centerButton = UIButton()
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var previousPage = 0
    private enum Constants {
        static let circularProgressAnimationKeyPath: String = "strokeEnd"
        static let progressAnimationKeyPath: String = "progressAnim"
    }
    private var previousValue: CGFloat = 0.0
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        createCircularPath()
        centerButton.layer.cornerRadius = centerButton.frame.width / 2
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = CirclePageControlScheme(theme: theme)
    }
    
    // MARK: - Public Methods
    
    public func setPage(_ page: Int, animated: Bool) {
        currentPage = page
        
        if currentPage > 0 && currentPage > previousPage {
            previousPage = currentPage - 1
        } else if currentPage > 0 && currentPage < previousPage {
            previousPage = currentPage + 1
        } else {
            previousPage = currentPage
        }
        
        if !animated {
            progressWithouAnimation()
        } else {
            progressAnimation()
        }
    }

    // MARK: - Private Methods
    
    private func progressWithouAnimation() {
        let toValue = CGFloat(currentPage) / CGFloat(totalPages)
        
        guard toValue != previousValue else { return }
        
        if toValue == 0.0 {
            progressLayer.removeAllAnimations()
        }
        
        progressLayer.actions = ["strokeEnd": NSNull()]
        previousValue = toValue
        progressLayer.strokeEnd = toValue
        delegate?.didChangePage(page: currentPage)
    }
    
    private func progressAnimation() {
        let toValue = CGFloat(currentPage) / CGFloat(totalPages)
        
        guard toValue != previousValue else { return }
        
        let circularProgressAnimation = CABasicAnimation(keyPath: Constants.circularProgressAnimationKeyPath)
        circularProgressAnimation.delegate = self
        circularProgressAnimation.isRemovedOnCompletion = false
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = previousValue
        circularProgressAnimation.toValue = toValue
        previousValue = toValue

        progressLayer.strokeEnd = previousValue
        
        if currentPage > previousPage {
            circularProgressAnimation.fillMode = .forwards
        } else if currentPage < previousPage {
            circularProgressAnimation.fillMode = .backwards
        } else {
            circularProgressAnimation.fillMode = .both
        }
        
        progressLayer.add(circularProgressAnimation, forKey: Constants.progressAnimationKeyPath)
    }
    
    private func commomInit() {
        addSubviews()
        setupButtons()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(centerButton)
    }
    
    private func setupButtons() {
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.setImage(SystemAsset.Custom.CirclePageControl.arrowRight.image, for: [])
        centerButton.addTarget(self, action: #selector(tapCenterButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: (2 / 3)),
            centerButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (2 / 3))
        ])
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0),
            radius: frame.size.width / 2.0,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 3.0
        circleLayer.strokeColor = UIColor.clear.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    private func updateScheme() {
        progressLayer.strokeColor = scheme.progressColor.cgColor
        backgroundColor = scheme.backgroundColor.uiColor
        centerButton.backgroundColor = scheme.centerButtonBackgroundColor.uiColor
        centerButton.tintColor = scheme.buttonImageColor.uiColor
    }
    
    @objc private func tapCenterButton(sender: UIButton) {
        delegate?.didTapCenterButton()
    }
    
}

// MARK: - CAAnimationDelegate

extension CirclePageControl: CAAnimationDelegate {
    
    public func animationDidStart(_ anim: CAAnimation) {
        centerButton.isEnabled = false
        delegate?.didChangePage(page: currentPage)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        centerButton.isEnabled = true
        if currentPage == 0 {
            progressLayer.removeAllAnimations()
        }
    }
    
}
