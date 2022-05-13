//
//  Toolbar.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme

/// The style of toolbar items.
public enum ToolbarItemStyle {
    case horizontal
    case vertical
}

/// The style of selection items.
public enum ToolbarSelectionStyle {
    case highlighted
    case selected
}

public protocol ToolbarDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

/// Toolbar
open class Toolbar: UIView, AnyAppThemable {

    private enum Constants {
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 14.0
        static let oneWidthItem: CGFloat = 140
        static let maximumCount = 5
        static let spacing: CGFloat = LayoutGrid.halfModule * 7
        static let maximumSpacing: CGFloat = LayoutGrid.halfModule * 1.5
        
        static let leadingSpacing: CGFloat = LayoutGrid.doubleModule
        static let trailingSpacing: CGFloat = LayoutGrid.doubleModule
    }

    // MARK: - Public Properties

    open weak var delegate: ToolbarDelegate?
    open var scheme = ToolbarColorScheme() {
        didSet {
            configureScheme()
            updateStackViewIfNeeded()
        }
    }

    /// A style of toolbar items.
    open var style: ToolbarItemStyle = .vertical {
        didSet { updateStackView() }
    }

    /// A pre-selected index.
    open var selectedItem: Int? = nil {
        didSet { configureScheme() }
    }
    
    /// A pre-selected index.
    open var itemWidth: CGFloat = LayoutGrid.doubleModule * 3 {
        didSet { updateStackView() }
    }

    /// Type of item selection style
    open var selectionStyle: ToolbarSelectionStyle = .highlighted

    // MARK: - Private Properties

    private let stackView = UIStackView()
    private let overView = UIView()
    private var cornerRadius: CGFloat = LayoutGrid.doubleModule
    private var stackViewItems = [ToolbarItem]()
    private var toolbarSpacing: CGFloat?
    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()
    private var trailingConstraint = NSLayoutConstraint()

    // MARK: - AnyAppTheamable

    open func apply(theme: AppTheme) {
        scheme = ToolbarColorScheme(theme: theme)
    }

    // MARK: - Public Methods

    /// Set items for toolbar.
    /// - Parameter items: Items for toolbar.
    open func setItems(items: [ToolbarItem]) {
        stackViewItems = items
        updateStackView()
    }

    /// Sets the corner radius of toolbar.
    /// - Parameter radius: The  corner radius of toolbar.
    open func setCornerRadius(_ radius: CGFloat) {
        cornerRadius = radius
        configureScheme()
    }

    /// Sets the spacing between of toolbar items.
    /// - Parameter spacing: The spacing of between items.
    open func setToolbarSpacing(spacing: CGFloat) {
        toolbarSpacing = spacing
        updateLayout()
    }
    
    /// Sets width for items.
    /// - Parameter width: item width.
    open func setToolbarItemWidth(width: CGFloat) {
        itemWidth = width
    }

    /// Sets the enabled  status if current item.
    /// - Parameters:
    ///     - index: The index of item.
    ///     - isEnabled: The enbled state of selected item.
    open func setItemIsEnabled(at index: Int, isEnabled: Bool) {
        guard let item = stackView.arrangedSubviews[safe: index] as? UIControl  else { return }

        item.isEnabled = isEnabled
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
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        stackView.spacing = stackSpacing()
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureShadow()
        configureViews()
        setupStackViews()
        configureConstraints()
    }

    private func setupStackViews() {
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }
    
    private func updateStackViewIfNeeded() {
        if !stackViewItems.isEmpty {
            updateStackView()
        }
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [stackView].addToSuperview(overView)
    }

    private func configureConstraints() {
        leadingConstraint = overView.leadingAnchor.constraint(equalTo: leadingAnchor)
        trailingConstraint = overView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            overView.topAnchor.constraint(equalTo: topAnchor),
            overView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalTo: overView.bottomAnchor),
            overView.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 10),
            
            stackView.topAnchor.constraint(equalTo: overView.topAnchor, constant: LayoutGrid.module),
            overView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGrid.module),
            stackView.centerXAnchor.constraint(equalTo: overView.centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: overView.leadingAnchor, constant: LayoutGrid.doubleModule),
            overView.trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
    }

    private func configureScheme() {
        overView.backgroundColor = scheme.backgroundColor.uiColor
        overView.layer.shadowColor = scheme.shadowColor.uiColor.cgColor
        
        guard
            selectionStyle == .selected,
            let selectedItem = selectedItem,
            let item = stackView.arrangedSubviews[safe: selectedItem] as? UIControl
        else {
            return
        }
        item.isSelected = true
    }

    private func configureViews() {
        overView.layer.cornerRadius = cornerRadius
    }

    private func configureShadow() {
        overView.layer.shadowOpacity = Constants.shadowOpacity
        overView.layer.shadowOffset = CGSize(width: 0.0, height: LayoutGrid.halfModule)
        overView.layer.shadowRadius = Constants.shadowRadius
    }
    
    private func stackSpacing() -> CGFloat {
        guard let toolbarSpacing = toolbarSpacing else {
            if self.frame.size != .zero, !stackViewItems.isEmpty {
                let stackViewWidth = frame.size.width - Constants.leadingSpacing - Constants.trailingSpacing
                let summaryItemWidth = itemWidth * CGFloat(stackViewItems.count)
                let spacing = (stackViewWidth - summaryItemWidth) / CGFloat(stackViewItems.count)
                return spacing
            } else {
                return Constants.spacing
            }
        }
        
        return toolbarSpacing
    }

    private func updateLayout() {
        if frame.size != .zero {
            stackView.spacing = stackSpacing()
        }
        leadingConstraint.isActive = stackViewItems.count != 1
        trailingConstraint.isActive = stackViewItems.count != 1
        configureScheme()
    }

    private func updateStackView() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        guard stackViewItems.count > 0 else { return }
        
        for index in 0...stackViewItems.count - 1 {
            guard let item = stackViewItems[safe: index] else { return }
            switch style {
            case .horizontal:
                let toolbarItem = ToolbarHorizontalControl()
                toolbarItem.titleText = item.title
                toolbarItem.image = item.image
                toolbarItem.type = item.type
                toolbarItem.titleColor = item.titleColor
                toolbarItem.imageTintColor = item.imageTintColor
                toolbarItem.tag = index
                toolbarItem.addTarget(self, action: #selector(didSelectItem(sender:)), for: .touchUpInside)
                toolbarItem.scheme = scheme.itemColorScheme
                stackView.addArrangedSubview(toolbarItem)
            case .vertical:
                let toolbarItem = ToolbarVerticalControl()
                toolbarItem.titleText = item.title
                toolbarItem.image = item.image
                toolbarItem.type = item.type
                toolbarItem.titleColor = item.titleColor
                toolbarItem.imageTintColor = item.imageTintColor
                toolbarItem.tag = index
                toolbarItem.addTarget(self, action: #selector(didSelectItem(sender:)), for: .touchUpInside)
                toolbarItem.scheme = scheme.itemColorScheme
                toolbarItem.itemWidth = itemWidth
                stackView.addArrangedSubview(toolbarItem)
            }
        }
        updateLayout()
    }

    @objc private func didSelectItem(sender: UIControl) {
        guard
            let item = stackView.arrangedSubviews[safe: sender.tag] as? UIControl,
            item.state != .disabled else { return }

        switch selectionStyle {
        case .highlighted:
            item.isHighlighted = !item.isHighlighted
        case .selected:
            stackView.arrangedSubviews.forEach({ if $0.tag != sender.tag {
                ($0 as? UIControl)?.isSelected = false
            }})
            item.isSelected = !item.isSelected
        }

        delegate?.didSelectItem(at: sender.tag )
    }

}
