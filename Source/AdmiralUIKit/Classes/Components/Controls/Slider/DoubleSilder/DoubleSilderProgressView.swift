//
//  DoubleSilderProgressView.swift
//  AdmiralUIKit
//
//  Created on 22.11.2021.
//

import UIKit
import AdmiralTheme

final class DoubleSliderProgressView: UIView, AnyAppThemable {

    // MARK: - Internal Properties

    var progress: Float = 0.0 {
        didSet { calculateLayout() }
    }

    var lowerProgress: Float = 0.0 {
        didSet { calculateLayout() }
    }

    var upperProgress: Float = 0.0 {
        didSet { calculateLayout() }
    }

    var backgroundLineHeight: CGFloat = 2.0 {
        didSet { calculateLayout() }
    }

    var trailingMargin: CGFloat = 0.0 {
        didSet { calculateLayout() }
    }

    var progressColor: UIColor? {
        get { return progressView.backgroundColor }
        set { progressView.backgroundColor = newValue }
    }

    var backdoundProgressColor: UIColor? {
        get { return backgroundView.backgroundColor }
        set { backgroundView.backgroundColor = newValue }
    }

    // MARK: - Private properties

    private let progressView = UIView()
    private let backgroundView = UIView()

    // MARK: - Public Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        calculateLayout()
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        backgroundColor = .clear
        backdoundProgressColor = theme.colors.textSecondary.uiColor
        progressColor = theme.colors.elementAccent.uiColor
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubViews()
        configureUI()
    }

    private func addSubViews() {
        addSubview(backgroundView)
        addSubview(progressView)
    }

    private func configureUI() {
        apply(theme: defaultTheme)

        progressView.clipsToBounds = true
        backgroundView.clipsToBounds = true

        backgroundLineHeight = 2.0
        lowerProgress = 0
        upperProgress = 0
    }

    func positionForValue(value: Double) -> CGFloat {
        let rect = CGRect(origin: .zero, size: frame.size)
        let widthDifference = rect.width
        return widthDifference * CGFloat(Float(value))
    }

    private func calculateLayout() {
        let rect = CGRect(origin: .zero, size: frame.size)
        let lineHeight = backgroundLineHeight
        let startProgress = CGFloat(lowerProgress)
        let endProgress = CGFloat(upperProgress)

        backgroundView.frame.origin.x = rect.minX
        backgroundView.frame.origin.y = rect.minY + (rect.height - lineHeight) / 2
        backgroundView.frame.size.width = rect.width
        backgroundView.frame.size.height = lineHeight

        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2

        let lowerValuePosition = positionForValue(value: Double(startProgress))
        let upperValuePosition = positionForValue(value: Double(endProgress))

        progressView.frame.origin.x = lowerValuePosition
        progressView.frame.origin.y = rect.minY
        progressView.frame.size.width = CGFloat(upperValuePosition) - CGFloat(lowerValuePosition)
        progressView.frame.size.height = rect.height

        progressView.layer.cornerRadius = progressView.frame.height / 2
    }

}
