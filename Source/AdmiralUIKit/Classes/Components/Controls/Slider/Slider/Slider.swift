//
//  Slider.swift
//  AdmiralUI
//
//  Created on 22.10.2020.
//

import UIKit
import AdmiralTheme

/// A control for selecting a single value from a continuous range of values.
public final class Slider: UIControl, AnyAppThemable {

    private enum Constants {
        static let height: CGFloat = LayoutGrid.module * 4
        static let progressHeight: CGFloat = LayoutGrid.halfModule
        static let thumbSize: CGSize = CGSize(width: LayoutGrid.halfModule * 5, height: LayoutGrid.halfModule * 5)
        static let thumbTapSize: CGSize = CGSize(width: Constants.height, height: Constants.height)
    }
    
    // MARK: - Public Properties

    /// The slider’s current value.
    public var value: Float {
        get { return self.value(progress: progress, min: minimumValue, max: maximumValue) }
        set { self.progress = progress(value: newValue, min: minimumValue, max: maximumValue) }
    }

    /// The minimum value of the slider.
    public var minimumValue: Float = 0.0 {
        didSet { self.value = value(progress: progress, min: minimumValue, max: maximumValue) }
    }

    /// The maximum value of the slider
    public var maximumValue: Float = 1.0 {
        didSet { self.value = value(progress: progress, min: minimumValue, max: maximumValue) }
    }

    /// A Boolean value indicating whether the control is in the selected state.
    public override var isSelected: Bool {
        didSet { configure(for: state) }
    }

    /// A Boolean value indicating whether the control draws a highlight.
    public override var isHighlighted: Bool {
        didSet { configure(for: state) }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }

    /// Color scheme.
    public var scheme = SliderScheme() {
        didSet {
            updateScheme()
        }
    }

    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }

    // MARK: - Private properties

    private let thumbView = SliderThumbView()
    private let progressView = SliderProgressView()
    
    private var previousLocation: CGPoint = .zero
    private var progress: Float = 0.0 {
        didSet { calculateLayout() }
    }
    
    // MARK: - Public Methods

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Sets the slider’s current value, allowing you to animate the change visually.
    /// - Parameters:
    ///   - value: The new value to assign to the value property
    ///   - animated: Specify true to animate the change in value; otherwise, specify false.
    public func setValue(_ value: Float, animated: Bool) {
        if animated {
            UIView.animate(
                withDuration: Durations.Default.single,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.value = value
                },
                completion: nil)
        } else {
            self.value = value
        }
    }
    
    // MARK: - AnyAppThemable

    public func apply(theme: AppTheme) {
        progressView.apply(theme: theme)
        self.scheme = SliderScheme(theme: theme)
    }

    override  public func layoutSubviews() {
        super.layoutSubviews()
        calculateLayout()
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureUI()
    }

    private func addSubviews() {
        addSubview(progressView)
        addSubview(thumbView)
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        
        thumbView.isUserInteractionEnabled = false
        progressView.isUserInteractionEnabled = false
                        
        configure(for: state)
    }

    private func updateIfNeeded(for newState: UIControl.State) {
        guard newState.contains(state) else { return }
        configure(for: state)
    }

    private func configure(for state: UIControl.State) {
        let tintColor = scheme.tintColor.parameter(for: state)
        let thumbColor = scheme.thumbColor.parameter(for: state)
        let backgroundColor = scheme.backgroundColor.parameter(for: state)
        let thumbBorderColor = scheme.thumbBorderColor.parameter(for: state)
        
        thumbView.borderColor = thumbBorderColor?.uiColor
        thumbView.backgroundColor = thumbColor?.uiColor
        
        progressView.progressColor = tintColor?.uiColor
        progressView.backdoundProgressColor = backgroundColor?.uiColor
    }
    
    private func progress(value: Float, min: Float, max: Float) -> Float {
        guard max > min else { return 0 }
        return boundValue((value - min) / (max - min), min: 0, max: 1)
    }
    
    private func value(progress: Float, min: Float, max: Float) -> Float {
        guard max > min else { return max }
        return boundValue(progress * (max - min) + min, min: minimumValue, max: maximumValue)
    }
    
    private func calculateLayout() {
        let rect = CGRect(origin: .zero, size: frame.size)
        let progressHeight = Constants.progressHeight
        let thumbSize = Constants.thumbSize

        progressView.frame.origin.x = 0
        progressView.frame.origin.y = rect.midY - progressHeight / 2
        progressView.frame.size.width = rect.width
        progressView.frame.size.height = progressHeight
        progressView.trailingMargin = thumbSize.width / 2
        progressView.progress = progress
        
        thumbView.frame.size = thumbSize
        thumbView.frame.origin.x = ceil(CGFloat(progress) * (rect.width - thumbSize.width))
        thumbView.frame.origin.y = ceil(rect.midY - thumbView.frame.height / 2)
    }
    
    private func boundValue(_ value: Float, min minValue: Float, max maxValue: Float) -> Float {
        return min(max(value, minValue), maxValue)
    }
    
    func updateScheme() {
        configure(for: state)
    }
    
}

public  extension Slider {

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        previousLocation = location

        let thumbFrame = CGRect(
            x: thumbView.frame.minX - (Constants.thumbTapSize.width - Constants.thumbSize.width) / 2,
            y: thumbView.frame.minY - (Constants.thumbTapSize.height - Constants.thumbSize.height) / 2,
            width: Constants.thumbTapSize.width,
            height: Constants.thumbTapSize.height
        )

        if thumbFrame.contains(location) {
            thumbView.isHighlighted = true
        } else {
            thumbView.isHighlighted = false
        }

        return thumbView.isHighlighted
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        if thumbView.isHighlighted {
            let deltaWidth = frame.width - thumbView.frame.width

            if deltaWidth > 0 {
                let deltaLocation = location.x - previousLocation.x
                let deltaProgress = deltaLocation / deltaWidth
                progress = boundValue(progress + Float(deltaProgress), min: 0, max: 1)
            } else {
                progress = 0
            }
        }

        previousLocation = location
        sendActions(for: .valueChanged)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbView.isHighlighted = false
    }

    override func cancelTracking(with event: UIEvent?) {
        thumbView.isHighlighted = false
    }

}
