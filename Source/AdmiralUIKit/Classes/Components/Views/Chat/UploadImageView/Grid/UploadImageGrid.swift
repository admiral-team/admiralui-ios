//
//  UploadImageGrid.swift
//  AdmiralUIKit
//
//  Created on 19.01.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

/// The state that controls showing of error in UploadImageGridView.
public enum UploadImageGridState {
    /// The default state of UploadImageGrid.
    case `default`
    /// The error state of UploadImageGrid.
    case error
}

/**
 UploadImageGridView - the component that presents a container view with some models.

 You can create a UploadImageGridView with the zero frame rectangle by specifying the following parameters in init:

 - direction: ChatDirection - The direction of chatBubbleStatusView.
 - chatStatus: ChatStatus? - The status of chatBubbleStatusView.
 - chatTime: String? - The time of chatBubbleStatusView.
 - state: UploadImageGridState - The state of UploadImageGridView.
 - models: [UploadImageModel] - The initial models.
 ## Example to create UploadDocumentView
 # Code
 ```
 let uploadImageGridView = UploadImageGridView()
 uploadDocumentView.direction = .left
 uploadDocumentView.chatStatus = .receive
 uploadDocumentView.chatTime = "12:53"
```
 */
/// A view with center loading indicator.
public final class UploadImageGridView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 114
        static let height: CGFloat = 114
        static let imageSize: CGFloat = LayoutGrid.halfModule * 7
        static let cornerRadius: CGFloat = LayoutGrid.module
        static let padding: CGFloat = LayoutGrid.doubleModule
        static let chatBubbleBoxWidth: CGFloat = 53
        static let paddingBottom: CGFloat = LayoutGrid.halfModule
    }

    // MARK: - Public properties

    /// The state of UploadImageGrid.
    public var state: UploadImageGridState = .default {
        didSet {
            updateScheme()
            updateUI()
        }
    }

    /// An initial models.
    public var models: [UploadImageItem] = [] {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    /// The chatStatus.
    public var chatStatus: ChatStatus? = nil {
        didSet {
            chatBubbleStatusView.chatStatus = chatStatus
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

    /// ChatBubbleStatusView time label text.
    public var chatTime: String? {
        get { return chatBubbleStatusView.timeTitle }
        set {
            chatBubbleStatusView.timeTitle = newValue
            updateScheme()
        }
    }

    /// Color scheme.
    public var scheme = UploadImageGridViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private let gridStyle: [[UploadImageViewCornerStyle]] = [
        [.allSides],
        [.leftSide, .rightSide],
        [.top, .bottomLeft, .bottomRight],
        [.topLeft, .topRight, .bottomLeft, .bottomRight],
        [.top , .none, .none, .bottomLeft, .bottomRight],
        [.topLeft, .topRight, .none, .none, .bottomLeft, .bottomRight]
    ]

    private let errorView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Service.Solid.errorSolid.image
        return imageView
    }()

    private let overView = UIView()
    private let chatBubbleBox = UIView()
    private let chatBubbleStatusView = ChatBubbleStatusView()
    private var heightConstraint = NSLayoutConstraint()
    private var trailingConstraint = NSLayoutConstraint()

    // MARK: - Computed Properties

    private var grid: [[UploadImageItem]] {
        models.chunks(2).reversed()
    }

    private var isChatBubbleHidden : Bool {
        guard models.count > 0 else {
            return true
        }
        return (models.first(where: { $0.state == .loading }) != nil)
    }

    private var isErrorExists: Bool {
        models.contains(where: { $0.state == .error })
    }

    // MARK: - Initializer

    public init(
        models: [UploadImageItem] = [],
        chatStatus: ChatStatus = .none,
        direction: ChatDirection = .right,
        chatTime: String? = nil
    ) {
        self.models = models
        super.init(frame: .zero)
        self.chatTime = chatTime
        self.direction = direction
        self.chatStatus = chatStatus
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        self.scheme = UploadImageGridViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        configureUI()
    }

    private func addSubviews() {
        [overView, chatBubbleBox, errorView].addToSuperview(self)
        [chatBubbleStatusView].addToSuperview(chatBubbleBox)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateGrid()
    }

    private func updateGrid() {
        overView.subviews.forEach { $0.removeFromSuperview() }
        chatBubbleBox.isHidden = isChatBubbleHidden
        grid.enumerated().forEach { rowIndex, row in
            for (modelIndex, _) in row.enumerated() {
                let model = grid[rowIndex][modelIndex]
                let uploadImageView = UploadImageView(frame: calculateFrame(row.count, modelIndex, rowIndex))
                uploadImageView.configure(with: model)
                uploadImageView.cornerStyle = getCornerStyle(modelIndex: modelIndex, rowIndex: rowIndex)
                overView.addSubview(uploadImageView)
            }
        }
        heightConstraint.constant = models.count == 0 ? .zero : (CGFloat(grid.count) * Constants.height) + (LayoutGrid.module * CGFloat(grid.count))
    }

    private func setupConstraints() {
        heightConstraint = overView.heightAnchor.constraint(equalToConstant: .zero)
        trailingConstraint = errorView.leadingAnchor.constraint(equalTo: overView.trailingAnchor)
        NSLayoutConstraint.activate([
            overView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overView.topAnchor.constraint(equalTo: topAnchor),
            overView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingConstraint,
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.width * 2)),

            overView.bottomAnchor.constraint(equalTo: chatBubbleBox.bottomAnchor, constant: LayoutGrid.doubleModule),
            overView.trailingAnchor.constraint(equalTo: chatBubbleBox.trailingAnchor, constant: LayoutGrid.module),

            chatBubbleBox.widthAnchor.constraint(equalToConstant: Constants.chatBubbleBoxWidth),
            chatBubbleBox.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),

            chatBubbleStatusView.centerXAnchor.constraint(equalTo: chatBubbleBox.centerXAnchor),
            chatBubbleStatusView.centerYAnchor.constraint(equalTo: chatBubbleBox.centerYAnchor),

            errorView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            errorView.heightAnchor.constraint(equalToConstant: Constants.imageSize),

            bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: Constants.paddingBottom),
            heightConstraint
        ])
    }

    private func configureUI() {
        chatBubbleBox.layer.cornerRadius = Constants.cornerRadius
        chatBubbleBox.backgroundColor = scheme.chatBubbleColor.uiColor
        errorView.tintColor = scheme.errorImageColor.uiColor
        chatBubbleStatusView.style = .light
    }

    private func updateUI() {
        switch (state, direction, isErrorExists) {
        case (.error, .right, false):
            errorView.isHidden = false
        default:
            errorView.isHidden = true
        }
        updateConstaints()
    }

    private func updateScheme() {
        updateColors()
        chatBubbleStatusView.scheme = scheme.chatBubbleStatusScheme
    }

    private func updateConstaints() {
        trailingConstraint.constant = state == .default ? .zero : Constants.padding
    }

    private func updateColors() {
        chatBubbleBox.backgroundColor = scheme.chatBubbleColor.uiColor
    }

}

// MARK: - Extensions

private extension UploadImageGridView {

    func calculateFrame(_ modelsCount: Int, _ modelIndex: Int, _ rowIndex: Int) -> CGRect {
        CGRect(
            x: CGFloat(modelIndex) * (Constants.width + LayoutGrid.module),
            y: CGFloat(rowIndex) * (Constants.height + LayoutGrid.module),
            width: modelsCount == 1 ? (Constants.width * 2) + LayoutGrid.module : Constants.width,
            height: Constants.height
        )
    }

    func getCornerStyle(modelIndex: Int, rowIndex: Int) -> UploadImageViewCornerStyle {
        let modelCornerStyle = grid[0..<rowIndex].joined().count + modelIndex
        return gridStyle[models.count - 1][modelCornerStyle]
    }

}
