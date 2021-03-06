//
//  ArrowListView.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A view object with arrow image view.
public class ArrowListView: BaseListView, TralingListViewComponent, AnyAppThemable {
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    var scheme = ArrowListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let arrowImageView = UIImageView()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = ArrowListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        arrowImageView.tintColor = scheme.imageTintColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [arrowImageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let top = arrowImageView.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: (LayoutGrid.halfModule / 2) * 11)
        let center = arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        center.priority = .defaultHigh
        let trailing = trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule)
        let arrowImageViewWidth = arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule)
        let arrowImageViewHeight = arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule)
        
        let widthConstraint = widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.quadrupleModule)
        widthConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)

        NSLayoutConstraint.activate([
            top,
            center,
            arrowImageViewWidth,
            trailing,
            arrowImageViewHeight,
            widthConstraint
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        arrowImageView.image = PrivateAsset.Custom.Cell.arrow.image
        arrowImageView.contentMode = .right
    }
    
}
