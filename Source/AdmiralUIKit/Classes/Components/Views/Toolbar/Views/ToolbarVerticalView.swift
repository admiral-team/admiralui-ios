//
//  ToolbarVerticalView.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme

class ToolbarVerticalControl: UIControl, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var scheme = ToolbarItemColorScheme() {
        didSet { configure() }
    }
    
    /// The title text of toolbar item
    var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// An image of toolbar item
    var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    /// The type toolbar item.
    var type: ToolbarItemType? {
        didSet { configure() }
    }
    
    /// Title color.
    var titleColor: UIColor? {
        didSet { configure() }
    }
    
    /// Image tint color.
    var imageTintColor: UIColor? {
        didSet { configure() }
    }
    
    /// Item width.
    var itemWidth: CGFloat {
        get { return widthConstraint.constant }
        set { widthConstraint.constant = newValue }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    override var isEnabled: Bool {
        didSet { configure() }
    }
    
    /// A Boolean value indicating whether the control is in the selected state.
    override var isSelected: Bool {
        didSet { configure() }
    }
    
    /// A Boolean value indicating whether the control is in the highlighted state.
    override var isHighlighted: Bool {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    private lazy var widthConstraint: NSLayoutConstraint = {
        return widthAnchor.constraint(equalToConstant: LayoutGrid.doubleModule * 3)
    }()
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = ToolbarItemColorScheme(theme: theme)
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupLabels()
        configureConstraints()
    }
    
    private func setupLabels() {
        titleLabel.textAlignment = .center
    }
    
    private func addSubviews() {
        [titleLabel, imageView].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule * 3),
            widthConstraint
        ])
    }
    
    private func configure() {
        titleLabel.font = scheme.titleLabelFontVertical
        
        if let type = type {
            titleLabel.textColor = scheme.titleColor.parameter(for: state, type: type)?.uiColor
            imageView.tintColor = scheme.imageColor.parameter(for: state, type: type)?.uiColor
        } else {
            titleLabel.textColor = titleColor
            imageView.tintColor = imageTintColor
        }
    }
    
}
