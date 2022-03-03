//
//  IconListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with icon view.
public class IconListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
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
    
    var scheme = IconListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()

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
        scheme = IconListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        imageView.tintColor = scheme.imageTintColor.parameter(for: state)?.uiColor
        if imageView.image?.renderingMode != UIImage.RenderingMode.alwaysTemplate {
            imageView.alpha = scheme.imageViewAlpha.parameter(for: state) ?? 1.0
        }
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [imageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.quadrupleModule)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        imageView.contentMode = .scaleAspectFit
    }

}
