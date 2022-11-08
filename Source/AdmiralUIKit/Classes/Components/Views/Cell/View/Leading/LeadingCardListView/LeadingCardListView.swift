//
//  CardListView.swift
//  AdmiralUI
//
//  Created on 20.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with card image view.
public class LeadingCardListView: BaseListView, LeadingListViewComponent, AnyAppThemable {
    
    /// The image displayed in the card image view.
    public var cardImage: UIImage? {
        didSet { imageView.image = cardImage }
    }
    
    // MARK: Internal Properties
    
    var scheme = LeadingCardListViewScheme() {
        didSet { updateScheme() }
    }
    
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
        scheme = LeadingCardListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        
        imageView.alpha = scheme.imageViewAlpha.parameter(for: state) ?? 1.0
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
        let top = imageView.topAnchor.constraint(equalTo: topAnchor)
        let leading = imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        let bottom = bottomAnchor.constraint(equalTo: imageView.bottomAnchor)

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            bottom
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        imageView.contentMode = .left
    }
    
}
