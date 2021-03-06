//
//  SubtitleWithImageListView.swift
//  AdmiralUI
//
//  Created on 04.03.2021.
//

import UIKit
import AdmiralTheme

/// A view object with subtitle label and image view.
public class SubtitleWithImageListView: BaseListView, TralingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The text that the subtitle label displays.
    public var subtitle: String? {
        didSet { subtitleLabel.text = subtitle }
    }
    
    /// The image displayed in the image view.
    public var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    var scheme = SubtitleWithImageListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = SubtitleWithImageListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        configure(for: state)
    }
    
    private func updateSchemeFonts() {
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.parameter(for: state)?.uiColor
        imageView.tintColor = scheme.imageTintColor.parameter(for: state)?.uiColor
        
        if imageView.image?.renderingMode != UIImage.RenderingMode.alwaysTemplate {
            imageView.alpha = isEnabled ? 1.0 : 0.5
        }
        imageView.contentMode = .center
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [subtitleLabel, imageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        leadingConstraint.priority = .defaultHigh
        
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.doubleModule * 8)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            leadingConstraint,
            
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .right
        
        imageView.contentMode = .scaleAspectFill
    }

}
