//
//  GroupTabSegmentControl.swift
//  AdmiralUI
//
//  Created on 28.10.2020.
//

import UIKit
import AdmiralTheme

/// Item for Outline slider tab.
public struct OutlineSliderTabItem {

    // MARK: - Public Properties

    /// Title item.
    public let title: String

    /// Badge style. Default is none.
    public var badgeStyle: BadgeStyle?

    /// The accesibility identifier
    public var accesibilityId: String?

    // MARK: - Initializer

    public init(title: String, badgeStyle: BadgeStyle?, accesibilityId: String? = nil) {
        self.title = title
        self.badgeStyle = badgeStyle
        self.accesibilityId = accesibilityId
    }

}

/// A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button.
public class OutlineSliderTabSegmentedControl: BaseOutlineSliderSegmentedControl, AnyAppThemable {
    
    enum Constants {
        static let cellIdentifier = "Cell"
    }

    // MARK: - Public Properties

    /// Color scheme.
    public var scheme = OutlineSliderScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private Properties
    
    private var textItems: [OutlineSliderItem] {
        return items as? [OutlineSliderItem] !! fatalError("This is not TextTabSegmentView class")
    }
            
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with titles.
    public init(titles: [String?]) {
        super.init()
        commonInit()
        setTitles(titles)
    }

    /// Initializes and returns a newly allocated view object with titles by OutlineSliderTabItem array.
    public init(items: [OutlineSliderTabItem]) {
        super.init()
        commonInit()
        setItems(items)
    }

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public override init() {
        super.init()
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
    
    // MARK: - Public Methods
    
    /// Sets titles.
    /// - Parameter titles: A strings to display in the segments.
    public func setTitles(_ titles: [String?]) {
        let labels = titles.map() { createItem(title: $0) }
        set(items: labels)
    }

    /// Sets titles.
    /// - Parameter items: An array of OutlineSliderTabItem to display in the segments.
    public func setItems(_ items: [OutlineSliderTabItem]) {
        let labels = items.map() { createItem(
            title: $0.title,
            style: $0.badgeStyle,
            accesibilityId: $0.accesibilityId
        )}
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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier, for: indexPath
        ) as? OutlineSliderCollectionViewCell else { fatalError("No reusable cell") }
        
        cell.configure(model: items[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = OutlineSliderCollectionViewCell(frame: .zero)
        cell.configure(model: items[indexPath.row])
        return CGSize(width: cell.intrinsicContentSize.width, height: height)
    }
        
    // MARK: - AppThemeable
    
    public func apply(theme: AppTheme) {
        scheme = OutlineSliderScheme(theme: theme)
    }
    
    // MARK: - Internal Mehtods
    
    override func configure(for state: UIControl.State) {
        super.configure(for: state)
        collectionView.layer.borderColor = scheme.borderColor.parameter(for: state)?.cgColor
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        collectionView.register(OutlineSliderCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        apply(theme: defaultTheme)
        height = LayoutGrid.quadrupleModule
    }

    private func createItem(
        title: String?,
        style: BadgeStyle? = nil,
        accesibilityId: String? = nil
    ) -> OutlineSliderItem {
        let item = OutlineSliderItem(
            isEnabled: isEnabled,
            isSelected: false,
            title: title,
            scheme: scheme,
            badgeStyle: style,
            accesibilityId: accesibilityId
        )
        
        return item
    }
    
    private func updateScheme() {
        textItems.forEach() { $0.scheme = scheme }
        configure(for: state)
        reloadData()
    }
            
}
