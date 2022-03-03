//
//  DoubleSlider.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import UIKit
import AdmiralTheme

/// A control for selecting a single value from a continuous range of values.
public final class DoubleSlider: UIControl, AnyAppThemable {

    private enum Constants {
        static let height: CGFloat = LayoutGrid.module * 4
        static let progressHeight: CGFloat = LayoutGrid.halfModule
        static let thumbSize: CGSize = CGSize(width: LayoutGrid.halfModule * 5, height: LayoutGrid.halfModule * 5)
        static let thumbTapSize: CGSize = CGSize(width: Constants.height, height: Constants.height)
    }

    // MARK: - Public Properties

    public var lowerValue: Float {
        get { return self.value(progress: lowerProgress, min: minimumValue, max: maximumValue) }
        set { self.lowerProgress = progress(value: newValue, min: minimumValue, max: maximumValue) }
    }

    public var upperValue: Float {
        get { return self.value(progress: upperProgress, min: minimumValue, max: maximumValue) }
        set { self.upperProgress = progress(value: newValue, min: minimumValue, max: maximumValue) }
    }

    /// The minimum value of the slider.
    public var minimumValue: Float = 0.0 {
        didSet {
            self.lowerValue = value(progress: lowerProgress, min: minimumValue, max: maximumValue)
            self.upperValue = value(progress: upperProgress, min: minimumValue, max: maximumValue)
        }
    }

    /// The maximum value of the slider
    public var maximumValue: Float = 1.0 {
        didSet {
            self.lowerValue = value(progress: lowerProgress, min: minimumValue, max: maximumValue)
            self.upperValue = value(progress: upperProgress, min: minimumValue, max: maximumValue)
        }
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

    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }

    // MARK: - Internal Properties

    var scheme = SliderScheme()

    // MARK: - Private properties

    private let lowerThumbImageView = SliderThumbView()
    private let upperThumbImageView = SliderThumbView()
    private let progressView = DoubleSliderProgressView()
    private var previousLocation: CGPoint = .zero

    private var lowerProgress: Float = 0.0 {
        didSet { calculateLayout() }
    }

    private var upperProgress: Float = 0.0 {
        didSet { calculateLayout() }
    }

    // MARK: - Initializer

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


    // MARK: - Public Methods

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
                    self.lowerValue = value
                },
                completion: nil)
        } else {
            self.lowerValue = value
        }
    }

    public func setValue(upperValue: Float, animated: Bool) {
        if animated {
            UIView.animate(
                withDuration: Durations.Default.single,
                delay: 0,
                options: [.curveEaseInOut],
                animations: { self.upperValue = upperValue },
                completion: nil)
        } else {
            self.upperValue = upperValue
        }
    }

    // MARK: - AnyAppThemable

    public func apply(theme: AppTheme) {
        progressView.apply(theme: theme)
        self.scheme = SliderScheme(theme: theme)
    }

    override public func layoutSubviews() {
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
        addSubview(lowerThumbImageView)
        addSubview(upperThumbImageView)
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        lowerThumbImageView.isUserInteractionEnabled = false
        upperThumbImageView.isUserInteractionEnabled = false
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

        lowerThumbImageView.borderColor = thumbBorderColor?.uiColor
        lowerThumbImageView.backgroundColor = thumbColor?.uiColor

        upperThumbImageView.borderColor = thumbBorderColor?.uiColor
        upperThumbImageView.backgroundColor = thumbColor?.uiColor

        progressView.progressColor = tintColor?.uiColor
        progressView.backdoundProgressColor = backgroundColor?.uiColor
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

        progressView.lowerProgress = lowerProgress
        progressView.upperProgress = upperProgress

        lowerThumbImageView.frame.size = thumbSize
        lowerThumbImageView.frame.origin.x = ceil(CGFloat(lowerProgress) * (rect.width - thumbSize.width))
        lowerThumbImageView.frame.origin.y = ceil(rect.midY - lowerThumbImageView.frame.height / 2)

        upperThumbImageView.frame.size = thumbSize
        upperThumbImageView.frame.origin.x = ceil(CGFloat(upperProgress) * (rect.width - thumbSize.width))
        upperThumbImageView.frame.origin.y = ceil(rect.midY - upperThumbImageView.frame.height / 2)
    }

    func positionForValue(value: Double) -> CGFloat {
        let rect = CGRect(origin: .zero, size: frame.size)
        let widthDifference = rect.width
        return widthDifference * CGFloat(Float(value) - minimumValue) / CGFloat(maximumValue - minimumValue)
    }

    func updateScheme() {
        configure(for: state)
    }

}


// MARK: - Calculating

private extension DoubleSlider {

    func boundValue(_ value: Float, min minValue: Float, max maxValue: Float) -> Float {
        return min(max(value, minValue), maxValue)
    }

    func progress(value: Float, min: Float, max: Float) -> Float {
        guard max > min else { return 0 }
        return boundValue((value - min) / (max - min), min: 0, max: 1)
    }

    func value(progress: Float, min: Float, max: Float) -> Float {
        guard max > min else { return max }
        return boundValue(progress * (max - min) + min, min: minimumValue, max: maximumValue)
    }

}

// MARK: - Tracking

public extension DoubleSlider {


    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        previousLocation = location

        let lowerThumbFrame = CGRect(
            x: lowerThumbImageView.frame.minX - (Constants.thumbTapSize.width - Constants.thumbSize.width) / 2,
            y: lowerThumbImageView.frame.minY - (Constants.thumbTapSize.height - Constants.thumbSize.height) / 2,
            width: Constants.thumbTapSize.width,
            height: Constants.thumbTapSize.height
        )

        let upperThumbFrame = CGRect(
            x: upperThumbImageView.frame.minX - (Constants.thumbTapSize.width - Constants.thumbSize.width) / 2,
            y: upperThumbImageView.frame.minY - (Constants.thumbTapSize.height - Constants.thumbSize.height) / 2,
            width: Constants.thumbTapSize.width,
            height: Constants.thumbTapSize.height
        )

        if upperThumbFrame.contains(location) {
            upperThumbImageView.isHighlighted = true
        } else if lowerThumbFrame.contains(location) {
            lowerThumbImageView.isHighlighted = true
        }
        return upperThumbImageView.isHighlighted || lowerThumbImageView.isHighlighted
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        if lowerThumbImageView.isHighlighted {
            let deltaWidth = frame.width - lowerThumbImageView.frame.width
            if deltaWidth > 0 {
                let deltaLocation = location.x - previousLocation.x
                let deltaProgress = deltaLocation / deltaWidth
                lowerProgress = boundValue(lowerProgress + Float(deltaProgress), min: 0, max: upperProgress)
            } else {
                lowerProgress = 0
            }
        } else if upperThumbImageView.isHighlighted {
            let deltaWidth = frame.width - upperThumbImageView.frame.width
            if deltaWidth > 0 {
                let deltaLocation = location.x - previousLocation.x
                let deltaProgress = deltaLocation / deltaWidth
                upperProgress = boundValue(upperProgress + Float(deltaProgress), min: lowerProgress, max: 1)
            } else {
                upperProgress = 0
            }
        }
        previousLocation = location
        sendActions(for: .valueChanged)
        return true
    }

    // MARK: - Private funcsmaximumValue

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }

    override func cancelTracking(with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }

}

