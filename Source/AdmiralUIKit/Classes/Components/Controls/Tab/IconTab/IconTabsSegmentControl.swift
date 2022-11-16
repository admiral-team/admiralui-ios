//
//  IconTabsSegmentControl.swift
//  AdmiralUI
//
//  Created on 12.02.2021.
//

import UIKit
import AdmiralTheme

public struct IconTab {
    let title: String?
    let image: UIImage
    let accesibilityId: String?
    
    public init(title: String, image: UIImage, accesibilityId: String? = nil) {
        self.title = title
        self.image = image
        self.accesibilityId = accesibilityId
    }
}

/// A horizontal control made of multiple segments with icons
public class IconTabsSegmentControl: UIControl, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// The index number identifying the selected segment (that is, the last segment touched).
    public var selectedSegmentIndex: Int {
        get { return selectedIndex }
        set { setSelectView(newValue) }
    }
    
    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return items.count
    }
    
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    // MARK: - Internal Properties
    
    var items: [IconTabsItem] = [] {
        didSet { updateItems() }
    }
    
    var height: CGFloat = LayoutGrid.quadrupleModule {
        didSet { updateHeightConstraint() }
    }
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGrid.halfModule * 15
        
        return stackView
    }()
    
    private var selectedIndex: Int = 0
    private var heightStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with titles.
    /// Initializes and returns a newly allocated view object with images.
    public convenience init(items: [IconTab]) {
        self.init(frame: .zero)
        let items = items.map() { createItem(iconTab: $0) }
        set(items: items)
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        stackView.arrangedSubviews.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
    }
    
    // MARK: - Public Methods
    
    /// Set selected segment index.
    /// - Parameters:
    ///   - index: Selected segment index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        setSelectView(index)
    }

    // MARK: - Internal Methods
    
    func set(items: [IconTabsItem]) {
        stackView.arrangedSubviews.forEach() { stackView.removeArrangedSubview($0) }
        items.enumerated().forEach() {
            prepare(view: $0.element, index: $0.offset)
            stackView.addArrangedSubview($0.element)
        }
        self.items = items
        selectedIndex = 0
    }
    
    func insert(item: IconTabsItem, at index: Int) {
        let newIndex = limit(index, min: 0, max: items.count)
        prepare(view: item, index: newIndex)
        stackView.insertArrangedSubview(item, at: newIndex)
        items.insert(item, at: newIndex)
    }
    
    func remove(view: IconTabsItem, at index: Int) {
        guard items.count > index else { return }
        
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
        items.remove(at: index)
    }
    
    func removeAllViews() {
        items = []
        stackView.arrangedSubviews.forEach() { stackView.removeArrangedSubview($0) }
        selectedIndex = 0
    }
    
    func prepare(view: UIControl, index: Int) {
        view.addTarget(self, action: #selector(tapSegment(_:)), for: .touchUpInside)
        view.tag = index
    }
    
    func configure(view: IconTabsItem, index: Int) {
        let isSelected = index == selectedIndex
        view.isSelected = isSelected
    }
    
    func configure(for state: UIControl.State) {
        if state.contains(.disabled) {
            items.forEach() { $0.isEnabled = false }
        } else {
            items.forEach() { $0.isEnabled = true }
        }
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        configureUI()
        setupConstraints()
    }
    
    private func updateItems() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for index in 0..<items.count {
            prepare(view: items[index], index: index)
            stackView.insertArrangedSubview(items[index], at: index)
        }
    }
    
    private func addSubviews() {
        [stackView].addToSuperview(self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setSelectView(_ index: Int) {
        selectedIndex = index
        sendActions(for: UIControl.Event.valueChanged)
        
        for i in 0..<items.count {
            configure(view: items[i], index: i)
        }
    }
    
    private func createItem(iconTab: IconTab) -> IconTabsItem {
        let item = IconTabsItem()
        item.title = iconTab.title
        item.image = iconTab.image
        item.accessibilityIdentifier = iconTab.accesibilityId
        return item
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
    }
    
    @objc private func tapSegment(_ control: UIControl) {
        selectedSegmentIndex = control.tag
        sendActions(for: UIControl.Event.valueChanged)
    }
    
    private func updateHeightConstraint() {
        heightStackViewConstraint.constant = height
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
