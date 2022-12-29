//
//  PageControl.swift
//  AdmiralUI
//
//  Created on 19.12.2020.
//

import UIKit
import AdmiralTheme

public class PageControl: UIControl, AppThemeable {

    // MARK: - Public Properties
    
    /// The current page, shown by the receiver.
    public var currentPage: Int {
        get { return selectedIndex }
        set { setSelectView(newValue) }
    }
    
    /// The number of pages the receiver shows.
    public var numberOfPages: Int {
        get { return items.count }
        set { set(numberOfPages: newValue) }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }

    /// Color scheme.
    public var scheme = PageControlViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Internal Properties
    
    var isTappableItem = false
    
    var items: [РageItemControl] = [] {
        didSet { updateItems() }
    }
    
    var height: CGFloat = LayoutGrid.quadrupleModule
    
    // MARK: - Internal Properties
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = LayoutGrid.halfModule
        
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.canCancelContentTouches = true
        scrollView.delaysContentTouches = true

        return scrollView
    }()
    
    // MARK: - Private Properties
    
    private var selectedIndex: Int = 0
    
    // MARK: - Initializer
    
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
    
    public func apply(theme: AppTheme) {
        scheme = PageControlViewScheme(theme: theme)
    }
    
    // MARK: - Public Methods
    
    /// Set selected page index.
    /// - Parameters:
    ///   - index: Selected page index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        setSelectView(index)
    }

    // MARK: - Internal Methods
    
    func set(numberOfPages: Int) {
        stackView.arrangedSubviews.forEach() { stackView.removeArrangedSubview($0) }
        
        var items = [РageItemControl]()
        
        for _ in 0..<numberOfPages {
            items.append(РageItemControl())
        }
        
        items.enumerated().forEach() {
            prepare(view: $0.element, index: $0.offset)
            stackView.addArrangedSubview($0.element)
        }
        self.items = items
        currentPage = 0
    }
    
    func prepare(view: UIControl, index: Int) {
        guard isTappableItem else { return }
        
        view.addTarget(self, action: #selector(tapSegment(_:)), for: .touchUpInside)
        view.tag = index
    }
    
    func configure(view: РageItemControl, index: Int) {
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
        configureLayout()
    }
    
    private func addSubviews() {
        [scrollView].addToSuperview(self)
        [stackView].addToSuperview(scrollView)
    }
    
    private func updateScheme() {
        items.forEach() { $0.scheme = scheme }
        configure(for: state)
    }
    
    private func configureLayout() {
        let scrollViewTop = scrollView.topAnchor.constraint(equalTo: topAnchor)
        let scrollViewLeading = scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let scrollViewTrailing = trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let scrollViewHeight = scrollView.heightAnchor.constraint(equalToConstant: height)
        
        let stackViewLeading = stackView.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor)
        let stackViewTrailing = scrollView.trailingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor)
        let stackViewCenterX = stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let stackViewCenterY = stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        
        NSLayoutConstraint.activate([
            scrollViewTop,
            scrollViewLeading,
            scrollViewTrailing,
            scrollViewHeight,
            stackViewCenterX,
            stackViewCenterY,
            stackViewLeading,
            stackViewTrailing
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
        selectedIndex = control.tag
        setSelectView(selectedIndex)
        sendActions(for: UIControl.Event.valueChanged)
    }
    
    private func updateItems() {
        items.enumerated().forEach() {
            $0.element.tag = $0.offset
        }
    }
    
}
