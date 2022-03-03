//
//  ImageWithSubtitleListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with subtitle label and image view.
public class ImageWithSubtitleListView: BaseListView, TralingListViewComponent, AnyAppThemable, AccessibilitySupport {
    
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
    
    var scheme = ImageWithSubtitleListViewScheme() {
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
        scheme = ImageWithSubtitleListViewScheme(theme: theme)
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
        let leadingConstraint = subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGrid.halfModule)
        leadingConstraint.priority = .defaultHigh
        
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.doubleModule * 8)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            leadingConstraint,
            
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            
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
