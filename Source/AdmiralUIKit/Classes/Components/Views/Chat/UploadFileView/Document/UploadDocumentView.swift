//
//  UploadDocumentView.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// The state of UploadDocumentView.
public enum UploadDocumentState {
    /// The loading state of UploadDocumentView.
    case loading
    /// The description state of UploadDocumentView.
    case description
    /// The download state of UploadDocumentView.
    case download
}
/**
 UploadDocumentView - the component that presents a view with loader for uploading and downloading tasks.

 You can create a UploadDocumentView with the zero frame rectangle by specifying the following parameters in init:

 - state: UploadDocumentState - The current state of UploadDocumentView.
 - direction: ChatDirection - The direction of chatBubbleStatusView.
 - fileName: String? - The text of file name label.
 - fileSize: String? - The text of file file size label.
 - chatStatus: ChatStatus? - The status of chatBubbleStatusView.
 - trackProgressStyle: ProgressViewStyle - Loading circle style.
 - isAnimating: Bool - The flag that controls animation of trackView.
 - chatTime: String? - The time of chatBubbleStatusView.
 - progressCircleStyle: ProgressViewStyle? - The style of ProgressView.
 - trackProgressStyle: ProgressViewStyle - The style of CircularProgressView.

 ## Example to create UploadDocumentView
 # Code
 ```
 let uploadDocumentView = UploadDocumentView()
 uploadDocumentView.state = .loading
 uploadDocumentView.fileName = "File.pdf"
 uploadDocumentView.fileSize = "282 MB"
 uploadDocumentView.trackProgressStyle = .default
 uploadDocumentView.direction = .left
 uploadDocumentView.chatTime = "12:53"
```
 */
/// A view with center loading indicator.
public final class UploadDocumentView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let circleWidth: CGFloat = LayoutGrid.halfModule * 11
        static let circleHeight: CGFloat = LayoutGrid.halfModule * 11
        static let width: CGFloat = 234
        static let cornerRadius: CGFloat = LayoutGrid.halfModule * 3
    }

    // MARK: - Public properties

    /// The file document state.
    public var state: UploadDocumentState = .download {
        didSet {
            progressView.isAnimating = state == .loading
            updateScheme()
        }
    }

    /// The direction of chatBubbleStatusView.
    public var direction: ChatDirection = .right {
        didSet {
            chatBubbleStatusView.chatDirection = direction
            updateScheme()
        }
    }

    /// The chatStatus.
    public var chatStatus: ChatStatus? = nil {
        didSet {
            chatBubbleStatusView.chatStatus = chatStatus
            updateScheme()
        }
    }

    /// The text of file name label.
    public var fileName: String? {
        get {
            return fileNameLabel.text
        } set {
            fileNameLabel.text = newValue
        }
    }

    /// The text of file file size label.
    public var fileSize: String? {
        get {
            return fileSizeLabel.text
        } set {
            fileSizeLabel.text = newValue
        }
    }

    /// ChatBubbleStatusView time label text.
    public var chatTime: String? {
        get { return chatBubbleStatusView.timeTitle }
        set {
            chatBubbleStatusView.timeTitle = newValue
            updateScheme()
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
        }
    }

    /// The accessibility identifier
    public var accessibilityId: String? {
        get {
            return accessibilityIdentifier
        } set {
            accessibilityIdentifier = newValue
        }
    }

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Internal Properties

    var scheme = UploadDocumentViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private let fileNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    private var maskedCorner: CACornerMask {
        switch direction {
        case .left:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
        default:
            return [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    private var image: UIImage {
        switch state {
        case .loading:
            return Asset.Service.Outline.closeOutline.image
        case .download:
            return Asset.System.Outline.arrowDownOutline.image
        case .description:
            return Asset.Documents.Outline.descriptionOutline.image
        }
    }

    private let overView = UIView()
    private let circleView = UIView()
    private let fileSizeLabel = UILabel()
    private let progressView = ProgressView()
    private let chatBubbleStatusView = ChatBubbleStatusView()

    // MARK: - Initializer

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        self.scheme = UploadDocumentViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        configureUI()
        addSubviews()
        setupConstraints()
    }

    private func configureUI() {
        overView.layer.cornerRadius = Constants.cornerRadius
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [circleView, fileNameLabel, fileSizeLabel, chatBubbleStatusView].addToSuperview(overView)
        [progressView].addToSuperview(circleView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: overView.leadingAnchor),
            trailingAnchor.constraint(equalTo: overView.trailingAnchor),
            topAnchor.constraint(equalTo: overView.topAnchor),
            bottomAnchor.constraint(equalTo: overView.bottomAnchor),
            overView.widthAnchor.constraint(equalToConstant: Constants.width),

            circleView.topAnchor.constraint(equalTo: overView.topAnchor, constant: LayoutGrid.module),
            circleView.leadingAnchor.constraint(equalTo: overView.leadingAnchor, constant: LayoutGrid.tripleModule / 2),
            circleView.widthAnchor.constraint(equalToConstant: Constants.circleWidth),
            circleView.heightAnchor.constraint(equalToConstant: Constants.circleWidth),

            progressView.widthAnchor.constraint(equalToConstant: Constants.circleWidth),
            progressView.heightAnchor.constraint(equalToConstant: Constants.circleHeight),
            progressView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),

            fileNameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: LayoutGrid.doubleModule),
            overView.trailingAnchor.constraint(equalTo: fileNameLabel.trailingAnchor, constant: LayoutGrid.tripleModule / 2),
            fileNameLabel.topAnchor.constraint(equalTo: overView.topAnchor, constant: LayoutGrid.module),
            fileSizeLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: LayoutGrid.doubleModule),
            fileSizeLabel.topAnchor.constraint(equalTo: fileNameLabel.bottomAnchor),

            overView.trailingAnchor.constraint(equalTo: chatBubbleStatusView.trailingAnchor, constant: LayoutGrid.tripleModule / 2),
            fileSizeLabel.bottomAnchor.constraint(equalTo: chatBubbleStatusView.topAnchor, constant: LayoutGrid.module / 2),
            overView.bottomAnchor.constraint(equalTo: chatBubbleStatusView.bottomAnchor, constant: LayoutGrid.module)
        ])
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
        updateUI()
    }

    private func updateUI() {
        progressView.image = image
        overView.layer.maskedCorners = maskedCorner
    }

    private func updateColors() {
        overView.backgroundColor = scheme.backgroundColor.parameter(style: direction)?.uiColor
        fileNameLabel.textColor = scheme.nameTextColor.parameter(style: direction)?.uiColor
        fileSizeLabel.textColor = scheme.sizeColor.parameter(style: direction)?.uiColor
        progressView.scheme = scheme.progressViewScheme
        chatBubbleStatusView.scheme = scheme.chatBubbleStatusViewScheme
    }

    private func updateFonts() {
        fileNameLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        fileSizeLabel.setDynamicFont(
            font: scheme.sizeTextFont.uiFont,
            textStyle: scheme.sizeTextFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
