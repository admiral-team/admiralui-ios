//
//  BaseOutlineSliderSegmentedControl.swift
//  AdmiralUI
//
//  Created on 28.10.2020.
//

import UIKit

protocol BaseOutlineSliderItem: AnyObject {
    var isEnabled: Bool { get set }
    var isSelected: Bool { get set }
}

/// A horizontal control made of multiple segments, each segment functioning as a discrete button.
public class BaseOutlineSliderSegmentedControl: UIControl {
    
    typealias Item = BaseOutlineSliderItem

    // MARK: - Public Properties
    
    /// The index number identifying the selected segment (that is, the last segment touched).
    public var selectedSegmentIndex: Int {
        get { return selectedIndex }
        set { setSelectItem(newValue) }
    }
    
    /// A Boolean value that determines whether scrolling is enabled.
    public var isScrollEnabled: Bool {
        get { collectionView.isScrollEnabled }
        set { collectionView.isScrollEnabled = newValue }
    }
    
    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return items.count
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    /// The minimum spacing to use between items in the same row.
    public var interItemSpacing : CGFloat = 8.0 {
        didSet { collectionView.collectionViewLayout.invalidateLayout() }
    }
    
    /// The custom distance that the content view is inset from the safe area or scroll view edges.
    public var contentInset: UIEdgeInsets = .zero {
        didSet { collectionView.contentInset = contentInset }
    }
    
    // MARK: - Internal Properties
    
    var items: [Item] = [] {
        didSet { collectionView.reloadData() }
    }
    
    var height: CGFloat = LayoutGrid.quadrupleModule
    
    // MARK: - Internal Properties
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = interItemSpacing
        collectionViewLayout.sectionInset = .zero
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
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
    
    // MARK: - Public Methods
    
    /// Set selected segment index.
    /// - Parameters:
    ///   - index: Selected segment index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        setSelectItem(index)
    }

    // MARK: - Internal Methods
    
    func set(items: [Item]) {
        selectedIndex = 0
        self.items = items
    }
    
    func insert(item: Item, at index: Int) {
        let newIndex = limit(index, min: 0, max: items.count)
        prepare(model: item, index: newIndex)
        items.insert(item, at: newIndex)
        
        if selectedIndex >= newIndex {
            selectedIndex += 1
        }
        setSelectItem(selectedIndex)
    }
    
    func remove(view: Item, at index: Int) {
        guard items.count > index else { return }

        items.remove(at: index)
        
        if selectedIndex >= items.count, !items.isEmpty {
            selectedIndex -= 1
        }
        setSelectItem(selectedIndex)
    }
    
    func removeAllViews() {
        items = []
        selectedIndex = 0
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func prepare(model: Item, index: Int) {
        model.isSelected = selectedIndex == index
    }
    
    func configure(for state: UIControl.State) {
        if state.contains(.disabled) {
            items.forEach() { $0.isEnabled = false }
        } else {
            items.forEach() { $0.isEnabled = true }
        }
        reloadData()
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [collectionView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let collectionViewTop = collectionView.topAnchor.constraint(equalTo: topAnchor)
        let collectionViewLeading = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let collectionViewTrailing = trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        let collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: height)
        
        NSLayoutConstraint.activate([
            collectionViewTop,
            collectionViewLeading,
            collectionViewTrailing,
            collectionViewHeight,
        ])
    }
    
    private func setSelectItem(_ index: Int) {
        items.forEach({ $0.isSelected = false })
        selectedIndex = index
        items[safe: index]?.isSelected = true
        sendActions(for: UIControl.Event.valueChanged)
        reloadData()
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
        collectionView.backgroundColor = .clear
    }
    
}

extension BaseOutlineSliderSegmentedControl: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSegments
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Method for override")
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setSelectItem(indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
}
