//
//  BaseUnderlineSegmentedControl.swift
//  AdmiralUI
//
//  Created on 29.10.2020.
//

import UIKit

protocol BaseUnderlineSegmentedItem: AnyObject {
    var isEnabled: Bool { get set }
    var isSelected: Bool { get set }
}

public protocol BaseUnderlineSegmentedControlProtocol {
    var isScrollEnabled: Bool { get set }
}

/// A horizontal control made of multiple segments, each segment functioning as a discrete button.
public class BaseUnderlineSegmentedControl: UIControl, BaseUnderlineSegmentedControlProtocol {
    
    typealias Item = BaseUnderlineSegmentedItem
    
    // MARK: - Public Properties
    
    /// The index number identifying the selected segment (that is, the last segment touched).
    public var selectedSegmentIndex: Int {
        get { return selectedIndex }
        set {
            selectedIndex = newValue
            setSelectView(min(selectedIndex, items.count), animated: false)
        }
    }
    
    /// A Boolean value that determines whether scrolling is enabled.
    public var isScrollEnabled: Bool {
        get {
            return collectionView.isScrollEnabled
        } set {
            collectionView.isScrollEnabled = newValue
        }
    }

    /// Current state of UIControl.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }

    /// Returns the number of segments the receiver has.
    public var numberOfSegments: Int {
        return items.count
    }
    
    /// The minimum spacing to use between items in the same row.
    public var interItemSpacing : CGFloat = 8.0 {
        didSet { collectionView.collectionViewLayout.invalidateLayout() }
    }
    
    /// The custom distance that the content view is inset from the safe area or scroll view edges.
    public var contentInset : UIEdgeInsets = .zero {
        didSet { collectionView.contentInset = contentInset }
    }
    
    // MARK: - Internal Properties
    
    var items: [Item] = [] {
        didSet { updateItems() }
    }
        
    var height: CGFloat = LayoutGrid.quadrupleModule
    
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
    
    var thumbView = UIView()
    
    // MARK: - Private Properties
    
    private var selectedIndex: Int = 0
    private let thumbHeight: CGFloat = 2.0
    
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
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: height)
    }
    
    // MARK: - Public Methods
    
    /// Set selected segment index.
    /// - Parameters:
    ///   - index: Selected segment index.
    ///   - animated: true if the set of the select segment should be animated, otherwise false.
    public func setSelectedSegmentIndex(_ index: Int, animated: Bool) {
        selectedIndex = index
        setSelectView(index, animated: true)
    }

    // MARK: - Internal Methods
    
    func set(items: [Item]) {
        selectedIndex = 0
        self.items = items
        configureThumbView()
    }
    
    func insert(item: Item, at index: Int) {
        let newIndex = limit(index, min: 0, max: items.count)
        
        if selectedIndex >= newIndex {
            selectedIndex += 1
        }
        
        items.insert(item, at: newIndex)
    }
    
    func remove(view: Item, at index: Int) {
        guard items.count > index else { return }

        if selectedIndex >= items.count {
            selectedIndex -= 1
        }
        
        items.remove(at: index)
    }
    
    func removeAllViews() {
        selectedIndex = 0
        items = []
    }
    
    func configure(item: Item, index: Int) {
        let isSelected = index == selectedIndex
        item.isSelected = isSelected
    }

    func configure(for state: UIControl.State) {
        if state.contains(.disabled) {
            items.forEach() { $0.isEnabled = false }
        } else {
            items.forEach() { $0.isEnabled = true }
        }
        updateItems()
    }
    
    func updateItems() {
        collectionView.reloadData()
        configureThumbView()
    }
    
    func sizeItem(for index: Int) -> CGSize {
        return .zero
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [collectionView].addToSuperview(self)
        [thumbView].addToSuperview(collectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate(collectionView.fillView(view: self))
    }
    
    private func configureUI() {
        backgroundColor = UIColor.clear
        collectionView.backgroundColor = .clear
    }
    
    private func configureThumbView() {
        let index = items.count > selectedIndex ? selectedIndex : 0
        setSelectView(index, animated: false)
    }
    
    private func setSelectView(_ index: Int, animated: Bool) {
        guard !items.isEmpty else { return }
        
        let segmentWidth = sizeItem(for: index).width
        var widthX: CGFloat = 0.0
        for i in 0..<index {
            widthX += sizeItem(for: i).width
        }
        widthX += CGFloat(index) * interItemSpacing
        let origin = CGPoint(x: widthX, y: height - thumbHeight)
        
        if animated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.thumbView.frame = CGRect(
                        origin: origin,
                        size: CGSize(width: segmentWidth, height: self.thumbHeight))
                }, completion: nil)
        } else {
            thumbView.frame = CGRect(
                origin: origin,
                size: CGSize(width: segmentWidth, height: thumbHeight))
        }
        
        for index in 0..<items.count {
            configure(item: items[index], index: index)
        }
        collectionView.reloadData()
    }
    
}

extension BaseUnderlineSegmentedControl: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSegments
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Method for override")
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setSelectedSegmentIndex(indexPath.row, animated: true)
        sendActions(for: UIControl.Event.valueChanged)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
}
