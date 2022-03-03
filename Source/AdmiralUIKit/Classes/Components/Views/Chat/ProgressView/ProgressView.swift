//
//  ProgressView.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// The style of ProgressView.
public enum ProgressViewStyle: Int {
    /// Default style of ProgressView.
    case `default`
    /// Accent style of ProgressView.
    case accent
}
/**
 ProgressView - the component that used for showing view with center loading indicator.

 You can create a ProgressView with the zero frame rectangle by specifying the following parameters in init:

 - style: ProgressViewStyle - The style of progress spinner.
 - centerView: UIView - Central view of progress view.
 - trackProgressStyle: ProgressViewStyle - Loading circle style.
 - isAnimating: Bool - The flag that controls animation of trackView.

 ## Example to create ProgressView
 # Code
 ```
 let trackView = ProgressView()
 trackView.style = .accent
 trackView.centerView = UIImageView()
 trackView.trackProgressStyle = .accent
 trackView.isAnimating = true
```
 */
/// A view with center loading indicator.
public final class ProgressView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let trackWidth = LayoutGrid.halfModule * 9
        static let trackHeight = LayoutGrid.halfModule * 9
    }

    // MARK: - Public Properties

    /// Progress view style.
    public var style: ProgressViewStyle = .default {
        didSet {
            updateScheme()
        }
    }

    /// A center image of ImageView.
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    /// Loading circle style.
    public var trackProgressStyle: ProgressViewStyle = .default {
        didSet {
            trackView.style = trackProgressStyle
            updateScheme()
        }
    }

    /// The flag that controls animation of trackView.
    public var isAnimating = false {
        didSet {
            trackView.isAnimating = isAnimating
        }
    }

    // MARK: - Internal Properties

    var scheme = ProgressViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private let imageView = UIImageView()
    private let trackView = CircularTrackView()

    public func apply(theme: AppTheme) {
        self.scheme = ProgressViewScheme(theme: theme)
        trackView.apply(theme: theme)
    }

    // MARK: - Initializer
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Private methods

    private func commonInit() {
        autoManage()
        setupUI()
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        [trackView, imageView].addToSuperview(self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            trackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trackView.widthAnchor.constraint(equalToConstant: Constants.trackWidth),
            trackView.heightAnchor.constraint(equalToConstant: Constants.trackHeight),

            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupUI() {
        layer.cornerRadius = (LayoutGrid.halfModule / 2 ) * 11
    }

    private func updateScheme() {
        updateColors()
    }

    private func updateColors() {
        backgroundColor = scheme.backgroundColor.parameter(style: style)?.uiColor
        imageView.tintColor = scheme.iconColor.parameter(style: trackProgressStyle)?.uiColor
    }

}
