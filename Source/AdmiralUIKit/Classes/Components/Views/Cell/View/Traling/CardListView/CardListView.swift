//
//  CardListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with card image view.
public class CardListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// The image displayed in the card image view.
    public var cardImage: UIImage? {
        didSet { imageView.image = cardImage }
    }

    /// Color scheme.
    public var scheme = CardListViewScheme() {
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
        scheme = CardListViewScheme(theme: theme)
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
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.doubleModule * 4)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        let top = imageView.topAnchor.constraint(equalTo: topAnchor)
        let leading = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        let bottom = bottomAnchor.constraint(equalTo: imageView.bottomAnchor)

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            bottom,
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        imageView.contentMode = .right
    }

}
