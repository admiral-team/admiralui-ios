//
//  IconTabsItem.swift
//  AdmiralUI
//
//  Created on 12.02.2021.
//

import UIKit
import AdmiralTheme

final public class IconTabsItem: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    public override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    public override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    public override var isHighlighted: Bool {
        didSet { updateScheme() }
    }

    /// Color scheme.
    public var scheme = IconTabsItemScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Internal Properties
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
        
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let imageView = UIImageView()

    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.isUserInteractionEnabled = false
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = IconTabsItemScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupConstraints()
        configureUI()
    }
    
    private func addSubviews() {
        [titleLabel, contentView].addToSuperview(self)
        [imageView].addToSuperview(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            contentView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutGrid.module),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        updateScheme()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = .clear
        titleLabel.textColor = scheme.titleColor.parameter(for: state)?.uiColor
        imageView.tintColor = scheme.imageColor.parameter(for: state)?.uiColor
        contentView.backgroundColor = scheme.contentViewBackGroundColor.parameter(for: state)?.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
