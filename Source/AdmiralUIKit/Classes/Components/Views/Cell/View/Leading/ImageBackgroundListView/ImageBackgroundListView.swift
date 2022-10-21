//
//  ImageBackgroundListView.swift
//  AdmiralUI
//
//  Created on 20.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with background view and image view.
public class ImageBackgroundListView: BaseListView, LeadingListViewComponent, AnyAppThemable {
    
    enum Constants {
        static let imageBackgroundViewHeight: CGFloat = LayoutGrid.halfModule * 11
    }
    
    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    public var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    var scheme = ImageBackgroundListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    private let backgroundImageView = UIView()
    
    private var viewBackgroundColor = ControlParameter<UIColor>()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
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
        scheme = ImageBackgroundListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        backgroundImageView.backgroundColor = scheme.backgroundImageViewColor.parameter(for: state)?.uiColor
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
        [backgroundImageView].addToSuperview(self)
        [imageView].addToSuperview(backgroundImageView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: backgroundImageView.leadingAnchor),
            imageView.topAnchor.constraint(greaterThanOrEqualTo: backgroundImageView.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: backgroundImageView.bottomAnchor),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: backgroundImageView.trailingAnchor),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: Constants.imageBackgroundViewHeight),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.imageBackgroundViewHeight)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        imageView.contentMode = .scaleAspectFit
        
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = Constants.imageBackgroundViewHeight / 2
    }
    
}
