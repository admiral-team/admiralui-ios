//
//  UnderlineSegmentedControl.swift
//  AdmiralUI
//
//  Created on 29.10.2020.
//

import UIKit
import AdmiralTheme

/// A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button.
public class UnderlineSegmentedControl: BaseUnderlineSegmentedControl, AnyAppThemable {
    
    enum Constants {
        static let cellIdentifier = "Cell"
    }
    
    // MARK: - Public Properties
    
    public override var selectedSegmentIndex: Int {
        didSet { configureThumbView() }
    }

    // MARK: - Private Properties
    
    private var textItems: [UnderlineSliderItem] {
        return items as? [UnderlineSliderItem] !! fatalError("This is not TextTabSegmentView class")
    }

    private var scheme = UnderlineSliderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with items.
    public init(items: [String?]) {
        super.init()
        commonInit()
        setTitles(items)
    }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public override init() {
        super.init()
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    /// Sets titles.
    /// - Parameter titles: A strings to display in the segments.
    public func setTitles(_ titles: [String?]) {
        let labels = titles.map() { createItem(title: $0) }
        set(items: labels)
    }
    
    /// Inserts a segment at a specific position in the receiver and gives it a title as content.
    /// - Parameters:
    ///   - title: A string to use as the segment’s title.
    ///   - segment: An index number identifying a segment in the control.
    public func insertTitle(_ title: String?, forSegmentAt segment: Int) {
        let label = createItem(title: title)
        insert(item: label, at: segment)
    }
    
    /// Remove a segment at a specific position.
    /// - Parameter segment: An index number identifying a segment in the control.
    public func removeTitle(forSegmentAt segment: Int) {
        guard let item = textItems[safe: segment] else { return }
        remove(view: item, at: segment)
    }
    
    /// Sets the title of a segment.
    /// - Parameters:
    ///   - title: A string to display in the segment as its title.
    ///   - segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        textItems[safe: segment]?.title = title
    }
    
    /// Sets the enable state of a segment.
    /// - Parameters:
    ///   - isEnabled: A Boolean value indicating whether the control is in the enabled state.
    ///   - segment:  An index number identifying a segment in the control.
    public func setEnabled(_ isEnabled: Bool, forSegmentAt segment: Int) {
        textItems[safe: segment]?.isEnabled = isEnabled
        configureThumbView()
    }
    
    /// Returns the title of the specified segment.
    /// - Parameter segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    /// - Returns: Returns the string (title) assigned to the receiver as content. If no title has been set, it returns nil.
    public func titleForSegment(at segment: Int) -> String? {
        return textItems[safe: segment]?.title
    }
    
    /// Removes all segments of the receiver
    public func removeAllTitles() {
        removeAllViews()
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? UnderlineSliderViewCell else { fatalError("No reusable cell") }
        
        cell.configure(item: items[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeItem(for: indexPath.row)
    }
    
    // MARK: - AppThemeable
    
    public func apply(theme: AppTheme) {
        self.scheme = UnderlineSliderScheme(theme: theme)
    }
    
    // MARK: - Internal Mehtods
    
    override func configure(for state: UIControl.State) {
        super.configure(for: state)

        thumbView.backgroundColor = scheme.thumbColor.parameter(for: state)?.uiColor
    }
    
    override func sizeItem(for index: Int) -> CGSize {
        let cell = UnderlineSliderViewCell(frame: .zero)
        cell.configure(item: items[index])
        let widthItem: CGFloat = isStaticTabs ? (collectionView.frame.width / CGFloat(items.count)) : cell.intrinsicContentSize.width
        return CGSize(width: widthItem, height: height)
    }
    
    // MARK: - Layout Subviews
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setSelectedSegmentIndex(selectedSegmentIndex, animated: true)
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        collectionView.register(UnderlineSliderViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        height = LayoutGrid.quadrupleModule
        apply(theme: defaultTheme)
        addTarget(self, action: #selector(segmentIndexChange), for: .valueChanged)
    }
    
    @objc private func segmentIndexChange() {
        configureThumbView()
    }
    
    private func configureThumbView() {
        guard let view = textItems[safe: selectedSegmentIndex] else { return }

        let state: UIControl.State = view.isEnabled ? .selected : [.selected, .disabled]
        thumbView.backgroundColor = scheme.thumbColor.parameter(for: state)?.uiColor
    }

    private func createItem(title: String?) -> UnderlineSliderItem {
        let item = UnderlineSliderItem(
            isEnabled: isEnabled,
            isSelected: false,
            title: title,
            scheme: scheme)
        return item
    }
    
    private func updateScheme() {
        textItems.forEach() { $0.scheme = scheme }
        configure(for: state)
        updateItems()
    }
    
}
