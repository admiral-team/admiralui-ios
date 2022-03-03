//
//  SliderProgressView.swift
//  AdmiralUI
//
//  Created on 22.10.2020.
//
import UIKit
import AdmiralTheme

// A view that depicts the progress of a task over time.
final class SliderProgressView: UIView, AnyAppThemable {

    // MARK: - Internal Properties

    var progress: Float = 0.0 {
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
        progress = 0
    }

    private func calculateLayout() {
        let rect = CGRect(origin: .zero, size: frame.size)
        let lineHeight = backgroundLineHeight
        let progress = CGFloat(self.progress)

        backgroundView.frame.origin.x = rect.minX
        backgroundView.frame.origin.y = rect.minY + (rect.height - lineHeight) / 2
        backgroundView.frame.size.width = rect.width
        backgroundView.frame.size.height = lineHeight

        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2

        progressView.frame.origin.x = rect.minX
        progressView.frame.origin.y = rect.minY
        progressView.frame.size.width = trailingMargin + (rect.width - 2 * trailingMargin) * progress
        progressView.frame.size.height = rect.height

        progressView.layer.cornerRadius = progressView.frame.height / 2
    }

}

