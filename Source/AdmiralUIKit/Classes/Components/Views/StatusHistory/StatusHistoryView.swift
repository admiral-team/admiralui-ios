//
//  StatusHistoryView.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralTheme

/// Color status history view.
public enum StatusHistory: String {
    case done
    case hold
    case review
    case error
}

/// Protocol for status history view.
public protocol StatusHistoryViewDelegate: AnyObject {
    func statusHistoryViewTapClose(view: StatusHistoryView)
}

/// Type of size history view.
public enum StatusHistoryViewType: String {
    case standard
    case small
}

/// Type of color for summa labels.
public enum StatusHistorySumType: String {
    case increase
    case decrease
}

/// Status history view.
public class StatusHistoryView: UIView, AnyAppThemable {
    
    enum Constant {
        static let imageSmallSize: CGSize = CGSize(
            width: LayoutGrid.doubleModule * 3,
            height: LayoutGrid.doubleModule * 3)
        static let imageStandardSize: CGSize = CGSize(
            width: LayoutGrid.doubleModule * 4,
            height: LayoutGrid.doubleModule * 4)
    }
    
    // MARK: - Public Properties
    
    /// The status history view's delegate.
    public weak var delegate: StatusHistoryViewDelegate?
    
    /// Type of status history view.
    public var type: StatusHistoryViewType {
        didSet { updateType() }
    }
    
    /// Text for date label.
    public var date: String? {
        didSet { statusHistoryDateView.dateText = date }
    }
    
    /// Image for round image views.
    public var images: [UIImage] = [] {
        didSet { statusHistoryImagesView.images = images }
    }
    
    /// Text for sum label.
    public var sum: String? {
        didSet { statusHistorySumView.sum = sum }
    }
    
    /// Text for cross out sum label.
    public var crossOutSum: String? {
        didSet { statusHistorySumView.crossOutSum = crossOutSum }
    }
    
    /// Type of sum. Default is decrease
    public var statusHistorySumType: StatusHistorySumType = .decrease {
        didSet { statusHistorySumView.statusHistorySumType = statusHistorySumType }
    }
    
    /// Text for title label.
    public var title: String? {
        didSet { statusHistoryTitleView.title = title }
    }
    
    /// Text for subtitle label.
    public var subtitle: String? {
        didSet { statusHistoryTitleView.subtitle = subtitle }
    }
    
    /// Text for status label.
    public var statusText: String? {
        didSet { statusHistoryStatusView.statusText = statusText }
    }
    
    /// Status image.
    public var statusImage = UIImage() {
        didSet { statusHistoryStatusView.statusImage = statusImage }
    }
    
    /// Type for status. Default is hold.
    public var status: StatusHistory = .hold {
        didSet { statusHistoryStatusView.status = status }
    }

    /// Color scheme.
    public var scheme = StatusHistoryViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let statusHistoryDateView = StatusHistoryDateView()
    private var statusHistoryImagesView = StatusHistoryBaseImagesView()
    private let statusHistorySumView = StatusHistorySumView()
    private var statusHistoryTitleView = StatusHistoryTitleView()
    private let statusHistoryStatusView = StatusHistoryStatusView()
    
    private lazy var statusHistoryTitleViewHeightConstaint: NSLayoutConstraint = {
        return statusHistoryTitleView.heightAnchor.constraint(equalToConstant: 0.0)
    }()
    
    // MARK: - Initializer
    
    public init(type: StatusHistoryViewType) {
        self.type = type
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: LayoutGrid.doubleModule)
    }
    
    open func apply(theme: AppTheme) {
        scheme = StatusHistoryViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureConstraints()
        configureUI()
        updateType()
    }
    
    private func configureUI() {
        statusHistoryDateView.delegate = self
    }
    
    private func addSubviews() {
        [statusHistoryDateView,
         statusHistoryImagesView,
         statusHistorySumView,
         statusHistoryTitleView,
         statusHistoryStatusView].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            statusHistoryDateView.topAnchor.constraint(equalTo: topAnchor),
            statusHistoryDateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: statusHistoryDateView.trailingAnchor),
            
            statusHistoryImagesView.topAnchor.constraint(equalTo: statusHistoryDateView.bottomAnchor),
            statusHistoryImagesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: statusHistoryImagesView.trailingAnchor),
            
            statusHistorySumView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: statusHistorySumView.trailingAnchor),
            statusHistorySumView.topAnchor.constraint(equalTo: statusHistoryImagesView.bottomAnchor),
            
            statusHistoryTitleView.topAnchor.constraint(equalTo: statusHistorySumView.bottomAnchor),
            statusHistoryTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: statusHistoryTitleView.trailingAnchor),
            statusHistoryTitleViewHeightConstaint,
            
            statusHistoryStatusView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: statusHistoryStatusView.trailingAnchor),
            statusHistoryStatusView.topAnchor.constraint(equalTo: statusHistoryTitleView.bottomAnchor),
            statusHistoryStatusView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateType() {
        statusHistorySumView.type = type
        
        switch type {
        case .standard:
            statusHistoryTitleViewHeightConstaint.isActive = false
            statusHistoryTitleView.isHidden = false
            statusHistoryImagesView.imageViewSize = Constant.imageStandardSize
        case .small:
            statusHistoryTitleViewHeightConstaint.isActive = true
            statusHistoryTitleView.isHidden = true
            statusHistoryImagesView.imageViewSize = Constant.imageSmallSize
        }
    }
    
    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
        
        statusHistoryDateView.scheme = scheme.statusHistoryDateViewScheme
        statusHistoryImagesView.scheme = scheme.statusHistoryBaseImagesViewScheme
        statusHistorySumView.scheme = scheme.statusHistorySummaViewScheme
        statusHistoryTitleView.scheme = scheme.statusHistoryTitleViewScheme
        statusHistoryStatusView.scheme = scheme.statusHistoryStatusViewScheme
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension StatusHistoryView: StatusHistoryDateViewDelegate {
    
    func didTapClose() {
        delegate?.statusHistoryViewTapClose(view: self)
    }
    
}
