//
//  CountDownTimerView.swift
//  AdmiralUIKit
//
//  Created on 28.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

class CountDownTimerView: UIView, AnyAppThemable {
    
    enum Constants {
        static let animationDuration = CFTimeInterval(0.1)
        static let pi = CGFloat.pi
        static let startAngle: CGFloat = 0
        static let strokeWidth: CGFloat = LayoutGrid.halfModule / 2
        
        static let animationKey = "strokeEnd"
        static let ringLayerAnimationKey = "animateRing"
    }
    
    // MARK: - Internal Properties
    
    var scheme = CountDownTimerViewScheme() {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private var countFrom: Double = 0
    private var countTo: Double = 1
    
    private var timer: Timer?
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var circleLayer: CAShapeLayer = {
        let ringlayer = CAShapeLayer()
        ringlayer.fillColor = UIColor.clear.cgColor
        ringlayer.strokeColor = tintColor.cgColor
        ringlayer.lineCap = CAShapeLayerLineCap.round
        ringlayer.lineWidth = Constants.strokeWidth
        ringlayer.strokeStart = 0
        ringlayer.strokeEnd = 0
        return ringlayer
    }()

    private lazy var ringlayer: CAShapeLayer = {
        let ringlayer = CAShapeLayer()
        ringlayer.fillColor = UIColor.clear.cgColor
        ringlayer.strokeColor = tintColor.cgColor
        ringlayer.lineCap = CAShapeLayerLineCap.round
        ringlayer.lineWidth = Constants.strokeWidth
        ringlayer.strokeStart = 0
        ringlayer.strokeEnd = 0
        return ringlayer
    }()
    
    private var proportion = CGFloat(0) {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = (min(frame.size.width, frame.size.height) - Constants.strokeWidth - LayoutGrid.halfModule / 2) / 2
        let circlePath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: Constants.startAngle,
            endAngle: Constants.startAngle + 2 * Constants.pi,
            clockwise: true)
        circleLayer.path = circlePath.cgPath
        ringlayer.path = circlePath.cgPath
        ringlayer.strokeEnd = proportion
        
        textLabel.frame.size = CGSize(width: LayoutGrid.halfModule * 5, height: LayoutGrid.halfModule * 5)
        textLabel.frame.origin.x = frame.size.width / 2 - Constants.strokeWidth
        textLabel.frame.origin.y = frame.size.height / 2 - Constants.strokeWidth
    }
    
    // MARK: - AppTheamable
    
    func apply(theme: AppTheme) {
        scheme = CountDownTimerViewScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
    }
    
    func startTo(_ countTo: Int) {
        self.countFrom = Double(0)
        self.countTo = Double(countTo)
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.animationDuration, repeats: true) { [weak self] (timer) in
            guard let `self` = self else { return }
            
            self.countFrom += Constants.animationDuration
            if self.countFrom <= self.countTo {
                
                let from = CGFloat(self.countFrom - Constants.animationDuration) / CGFloat(self.countTo)
                let to = CGFloat(self.countFrom) / CGFloat(self.countTo)
                self.animateRing(from: from, to: to, duration: Constants.animationDuration)
                
                let count = Int(self.countTo) - Int(self.countFrom)
                self.textLabel.text = "\(count)"
            } else {
                self.textLabel.text = "\(0)"
                self.stopTimer()
            }
        }
                
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        layer.addSublayer(circleLayer)
        layer.addSublayer(ringlayer)
        
        addSubview(textLabel)
    }
    
    private func configure() {
        textLabel.textColor = scheme.titleTextColor.uiColor
        textLabel.font = scheme.titleTextFont.uiFont
        
        circleLayer.strokeColor = scheme.tintColor.uiColor.cgColor
        ringlayer.strokeColor = scheme.tintColor.uiColor.cgColor
    }

    private func animateRing(from startProportion: CGFloat, to endProportion: CGFloat, duration: CFTimeInterval) {
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: Constants.animationKey)
        animation.duration = duration
        animation.fromValue = startProportion
        animation.toValue = endProportion
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        ringlayer.strokeEnd = endProportion
        ringlayer.strokeStart = startProportion
        ringlayer.add(animation, forKey: Constants.ringLayerAnimationKey)
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let `self` = self else { return }
            self.circleLayer.strokeEnd = CGFloat(self.countFrom) / CGFloat(self.countTo)
        }
        
        CATransaction.commit()
    }
    
}
