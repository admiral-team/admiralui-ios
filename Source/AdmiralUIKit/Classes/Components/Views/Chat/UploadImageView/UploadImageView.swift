//
//  UploadImageView.swift
//  AdmiralUIKit
//
//  Created on 29.12.2021.
//

import AdmiralTheme
import UIKit

/// The state of UploadImageView.
public enum UploadImageViewState {
    /// The default state.
    case `default`
    /// The loading state.
    case loading
    /// The error state.
    case error
}

/// The style of UploadImageView.
public enum UploadImageViewStyle {
    /// The default state.
    case `default`
    /// The resized state.
    case resized
}

/// The corner style of UploadImageView.
public enum UploadImageViewCornerStyle {
    /// The leftSide state.
    case leftSide
    /// The rightSide state.
    case rightSide
    /// The bottom state.
    case bottom
    /// The top state.
    case top
    /// The allSides state.
    case allSides
    /// The bottomLeft state.
    case bottomLeft
    /// The bottomRight state.
    case bottomRight
    /// The topRight state.
    case topRight
    /// The topLeft state.
    case topLeft
    /// The none state.
    case none
}
/**
 UploadImageView - the component that presents backgound image with loader for uploading and downloading tasks.

 You can create a UploadImageView with the zero frame rectangle by specifying the following parameters in init:

 - state: UploadDocumentState - The current state of UploadDocumentView.
 - isAnimating: Bool - The flag that controls animation of trackView.
 - progressCircleStyle: ProgressViewStyle? - The style of ProgressView.
 - trackProgressStyle: ProgressViewStyle - The style of CircularProgressView.

 ## Example to create UploadImageView
 # Code
 ```
 let uploadImageView = UploadImageView()
 uploadDocumentView.state = .loading
 uploadDocumentView.trackProgressStyle = .default
```
 */
/// The view that presents backgound image with loader for uploading and downloading process.
public final class UploadImageView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 232
        static let height: CGFloat = 114
        static let resizedWidth: CGFloat = 114
        static let cornerRadius: CGFloat = LayoutGrid.halfModule * 3
        static let blurRadius: CGFloat = 0.4
    }

    // MARK: - Public properties

    /// The state of UploadImageView.
    public var state: UploadImageViewState = .default {
        didSet {
            progressView.isAnimating = state == .loading
            updateScheme()
        }
    }

    /// The style of UploadImageView.
    public var style: UploadImageViewStyle = .default {
        didSet {
            updateScheme()
        }
    }

    /// An image of image view.
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    /// The style of ProgressView.
    public var progressCircleStyle: ProgressViewStyle = .default {
        didSet {
            progressView.style = progressCircleStyle
            updateScheme()
        }
    }

    /// The style of track circle view.
    public var trackProgressStyle: ProgressViewStyle = .default {
        didSet {
            progressView.trackProgressStyle = trackProgressStyle
            updateScheme()
        }
    }

    /// Color scheme.
    public var scheme = UploadImageViewScheme() {
        didSet { updateScheme() }
    }

    /// The corner style of UploadImageView.
    public var cornerStyle: UploadImageViewCornerStyle = .allSides {
        didSet {
            switch cornerStyle {
            case .leftSide:
                overView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                maskedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            case .rightSide:
                overView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            case .bottom:
                overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            case .top:
                overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            case .allSides:
                overView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            case .bottomLeft:
                overView.layer.maskedCorners = [.layerMinXMaxYCorner]
                imageView.layer.maskedCorners = [.layerMinXMaxYCorner]
                maskedView.layer.maskedCorners = [.layerMinXMaxYCorner]
            case .bottomRight:
                overView.layer.maskedCorners = [.layerMaxXMaxYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMaxYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            case .topRight:
                overView.layer.maskedCorners = [.layerMaxXMinYCorner]
                imageView.layer.maskedCorners = [.layerMaxXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMaxXMinYCorner]
            case .topLeft:
                overView.layer.maskedCorners = [.layerMinXMinYCorner]
                imageView.layer.maskedCorners = [.layerMinXMinYCorner]
                maskedView.layer.maskedCorners = [.layerMinXMinYCorner]
            case .none:
                overView.layer.maskedCorners = []
                imageView.layer.maskedCorners = []
                maskedView.layer.maskedCorners = []
            }
        }
    }

    // MARK: - Private properties

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.alpha = Constants.blurRadius
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    private let overView = UIView()
    private let progressView = ProgressView()
    private let maskedView = UIView()

    // MARK: - Initializer

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        self.scheme = UploadImageViewScheme(theme: theme)
        progressView.apply(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        configureUI()
    }

    private func configureUI() {
        maskedView.layer.cornerRadius = Constants.cornerRadius
        overView.layer.cornerRadius = Constants.cornerRadius
        progressView.trackProgressStyle = .default
        maskedView.isHidden = true
        progressView.style = .default
        progressView.image = Asset.Service.Outline.closeOutline.image
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [imageView, maskedView].addToSuperview(overView)
        [progressView].addToSuperview(maskedView)
        [blurEffectView].addToSuperview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: overView.leadingAnchor),
            trailingAnchor.constraint(equalTo: overView.trailingAnchor),
            topAnchor.constraint(equalTo: overView.topAnchor),
            bottomAnchor.constraint(equalTo: overView.bottomAnchor),
            overView.widthAnchor.constraint(equalToConstant: Constants.width),
            overView.heightAnchor.constraint(equalToConstant: Constants.height),

            imageView.leadingAnchor.constraint(equalTo: overView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: overView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: overView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: overView.bottomAnchor),

            maskedView.leadingAnchor.constraint(equalTo: overView.leadingAnchor),
            maskedView.trailingAnchor.constraint(equalTo: overView.trailingAnchor),
            maskedView.topAnchor.constraint(equalTo: overView.topAnchor),
            maskedView.bottomAnchor.constraint(equalTo: overView.bottomAnchor),

            progressView.centerXAnchor.constraint(equalTo: maskedView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: maskedView.centerYAnchor),
        ])
    }

    private func updateScheme() {
        updateColors()
        updateUI()
    }

    private func updateUI() {
        maskedView.isHidden = state == .default
        progressView.isAnimating = state == .loading
        blurEffectView.isHidden = state == .default
    }

    private func updateColors() {
        maskedView.backgroundColor = scheme.chatBubbleColor.uiColor
        progressView.scheme = scheme.progressViewScheme
    }

}

extension UploadImageView {

    func configure(with model: UploadImageItem) {
        state = model.state ?? .default
        image = model.image
        style = model.style
        accessibilityIdentifier = model.accesibilityId
    }

}
