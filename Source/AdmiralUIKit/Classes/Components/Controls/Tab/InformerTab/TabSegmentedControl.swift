//
//  TabSegmentedControl.swift
//  AdmiralUI
//
//  Created on 05.11.2020.
//

import UIKit

/// A horizontal control made of multiple segments, each segment functioning as a discrete button.
public class TabSegmentedControl: UIControl {
    
    typealias ItemView = UIControl
    
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
    
    var items: [ItemView] = [] {
        didSet { updateItems() }
    }
    
    var height: CGFloat = LayoutGrid.quadrupleModule {
        didSet { updateHeightConstraint() }
    }
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = LayoutGrid.module
        
        return stackView
    }()
    
    private var selectedIndex: Int = 0
    private var heightStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Initializer
    
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
    
    // MARK: - Public Methods
    
    /// Set selected segment index.
    /// - Parameters:
    ///   - index: Selected segment index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        setSelectView(index)
    }

    // MARK: - Internal Methods
    
    func set(items: [ItemView]) {
        stackView.arrangedSubviews.forEach() { stackView.removeArrangedSubview($0) }
        items.enumerated().forEach() {
            prepare(view: $0.element, index: $0.offset)
            stackView.addArrangedSubview($0.element)
        }
        self.items = items
        selectedIndex = 0
    }
    
    func insert(item: ItemView, at index: Int) {
        let newIndex = limit(index, min: 0, max: items.count)
        prepare(view: item, index: newIndex)
        stackView.insertArrangedSubview(item, at: newIndex)
        self.items.insert(item, at: newIndex)
        
        if selectedIndex >= newIndex {
            selectedIndex += 1
        }
        setSelectView(selectedIndex)
    }
    
    func remove(view: ItemView, at index: Int) {
        guard items.count > index else { return }
        
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()

        items.remove(at: index)
        
        if selectedIndex >= items.count, !items.isEmpty {
            selectedIndex -= 1
        }
        setSelectView(selectedIndex)
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
    
    func configure(view: ItemView, index: Int) {
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
        addSubviews()
        configureUI()
        configureLayout()
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
    
    private func configureLayout() {
        let top = stackView.topAnchor.constraint(equalTo: topAnchor)
        let leading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        heightStackViewConstraint = stackView.heightAnchor.constraint(equalToConstant: height)

        NSLayoutConstraint.activate([
            top,
            leading,
            trailing,
            heightStackViewConstraint
        ])
    }
    
    private func setSelectView(_ index: Int) {
        selectedIndex = index
        sendActions(for: UIControl.Event.valueChanged)
        
        for i in 0..<items.count {
            configure(view: items[i], index: i)
        }
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
