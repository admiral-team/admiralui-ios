//
//  TextMessageView.swift
//  AdmiralUI
//
//  Created on 16.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with text message view.
public class TextMessageListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var text: String? {
        didSet { titleLabel.text = text }
    }

    /// Color scheme.
    public var scheme = TextMessageListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let messageView = UIView()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .topRight, .bottomRight], radius: LayoutGrid.doubleModule)
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = TextMessageListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        configure(for: state)
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.viewBackgroundColor.parameter(for: state)?.uiColor

        messageView.backgroundColor = scheme.messageViewBackgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.messageTitleLabelTitleColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [messageView].addToSuperview(self)
        [titleLabel].addToSuperview(messageView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: messageView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(greaterThanOrEqualTo: messageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            messageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(greaterThanOrEqualTo: messageView.bottomAnchor, constant: LayoutGrid.module),
            
            messageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: LayoutGrid.halfModule * 3),
            messageView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: messageView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        messageView.layer.mask = mask
    }
    
}
