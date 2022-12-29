//
//  CustomSegmentControl.swift
//  AdmiralUI
//
//  Created on 26.10.2020.
//

import UIKit

protocol SegmentControlItem: UIControl {
    var isSeparatorHidden: Bool { get set }
}

/// A horizontal control made of multiple segments, each segment functioning as a discrete button.
public class PlainSegmentedControl: UIControl {
    
    typealias ItemView = SegmentControlItem
    
    // MARK: - Public Properties
    
    /// The index number identifying the selected segment (that is, the last segment touched).
    public var selectedSegmentIndex: Int {
        get { return selectedIndex }
        set {
            selectedIndex = newValue
            setSelectView(min(selectedIndex, items.count), animated: false)
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return items.count
    }
    
    // MARK: - Internal Properties
    
    var items: [ItemView] = [] {
        didSet { updateItems() }
    }
    
    var height: CGFloat = LayoutGrid.quadrupleModule {
        didSet { updateHeightConstraint() }
    }
    
    let contentView = UIView()
    let thumbView = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    
    // MARK: - Private Properties
    
    private var selectedIndex: Int = 0
    private var heightStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Public Methods
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
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
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    /// Lays out subviews.
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureThumbView()
    }
    
    /// Set selected segment index.
    /// - Parameters:
    ///   - index: Selected segment index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        setSelectView(index, animated: animated)
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
        setSelectView(min(selectedIndex, items.count), animated: false)
    }
    
    func remove(view: ItemView, at index: Int) {
        guard items.count > index else { return }
        
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()

        items.remove(at: index)
        
        if selectedIndex >= items.count, !items.isEmpty {
            selectedIndex -= 1
        }
        
        setSelectView(min(selectedIndex, items.count), animated: false)
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
    
    private func configureThumbView() {
        let index = items.count > selectedIndex ? selectedIndex : 0
        setSelectView(index, animated: false)
    }
    
    private func addSubviews() {
        [contentView, stackView, thumbView].addToSuperview(self)
    }
    
    private func configureLayout() {
        heightStackViewConstraint = stackView.heightAnchor.constraint(equalToConstant: height)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: stackView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            heightStackViewConstraint
        ])
    }
    
    private func configureUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = LayoutGrid.module
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        thumbView.layer.borderWidth = 2
        thumbView.layer.borderColor = UIColor.black.cgColor
        thumbView.layer.cornerRadius = LayoutGrid.module
    }
    
    @objc private func tapSegment(_ control: UIControl) {
        selectedIndex = control.tag
        setSelectView(selectedIndex, animated: true)
        sendActions(for: UIControl.Event.valueChanged)
    }
    
    private func setSelectView(_ index: Int, animated: Bool) {
        guard !items.isEmpty else { return }
        
        let viewBorderWidth: CGFloat = 1.0
        let segmentWidth = stackView.frame.width / CGFloat(items.count)
        let origin = CGPoint(x: segmentWidth * CGFloat(index) - viewBorderWidth, y: 0.0)
        
        if animated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.thumbView.frame = CGRect(
                        origin: origin,
                        size: CGSize(width: segmentWidth + viewBorderWidth, height: self.height))
                }, completion: nil)
        } else {
            thumbView.frame = CGRect(
                origin: origin,
                size: CGSize(width: segmentWidth + viewBorderWidth, height: self.height))
        }
        
        for index in 0..<items.count {
            configure(view: items[index], index: index)
        }
    }
    
    private func updateHeightConstraint() {
        heightStackViewConstraint.constant = height
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func updateItems() {
        let isSepratorHidden = items.count < 3
        
        items.enumerated().forEach() {
            $0.element.tag = $0.offset
            $0.element.isSeparatorHidden = isSepratorHidden
        }
    }
    
}
