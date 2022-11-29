//
//  CurcleIconListView.swift
//  AdmiralUI
//
//  Created on 18.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with curcle view.
public class CurcleIconListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    public var image: UIImage? {
        didSet { imageView.image = image }
    }

    /// Color scheme.
    public var scheme = CurcleIconListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
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
        scheme = CurcleIconListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
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
        [imageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.doubleModule * 4)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 8),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 8),
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = LayoutGrid.halfModule * 4
    }

}
