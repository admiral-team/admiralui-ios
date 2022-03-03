//
//  InformerTabSegmentedControl.swift
//  AdmiralUI
//
//  Created on 06.11.2020.
//

import UIKit
import AdmiralTheme

public struct InformerTab {
    let title: String?
    let subtitle: String?
    
    public init(title: String?, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
}

/// A horizontal control that consists of multiple segments, each segment functioning as a discrete text button.
public class InformerTabSegmentedControl: TabSegmentedControl, SegmentControlContainerContent, AnyAppThemable {
    
    private enum Constants {
        static let height: CGFloat = 80.0
    }
    
    // MARK: - Internal Properties
    
    var scheme = InformerSegmentedScheme() {
        didSet { updateScheme() }
    }
        
    // MARK: - Private Properties
            
    private var textItems: [InformerSegmentedView] {
        return items as? [InformerSegmentedView] !! fatalError("This is not InformerSegmentedView class")
    }
    
    // MARK: - Initializer
    
    public convenience init(items: [InformerTab]) {
        self.init(frame: .zero)
        setItems(items)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    /// Sets segment view model.
    /// - Parameter viewModels: A view models to display in the segments.
    public func setItems(_ viewModels: [InformerTab]) {
        let views = viewModels.map() { createItem(item: $0) }
        set(items: views)
    }
    
    /// Inserts a segment at a specific position in the receiver and gives it a title as content.
    /// - Parameters:
    ///   - item: A item to use as the segment’s title.
    ///   - segment: An index number identifying a segment in the control.
    public func insertItem(_ item: InformerTab, forSegmentAt segment: Int) {
        let label = createItem(item: item)
        insert(item: label, at: segment)
    }
    
    /// Remove a segment at a specific position.
    /// - Parameter segment: An index number identifying a segment in the control.
    public func removeItem(forSegmentAt segment: Int) {
        guard let item = textItems[safe: segment] else { return }
        remove(view: item, at: segment)
    }
    
    /// Sets the enable state of a segment.
    /// - Parameters:
    ///   - isEnabled: A Boolean value indicating whether the control is in the enabled state.
    ///   - segment:  An index number identifying a segment in the control.
    public func setEnabled(_ isEnabled: Bool, forSegmentAt segment: Int) {
        textItems[safe: segment]?.isEnabled = isEnabled
    }
    
    /// Sets the title of a segment.
    /// - Parameters:
    ///   - item: A view model to display in the segment as its title.
    ///   - segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    public func setItem(_ item: InformerTab, forSegmentAt segment: Int) {
        textItems[safe: segment]?.title = item.title
        textItems[safe: segment]?.subtitle = item.subtitle
    }
    
    /// Returns the title of the specified segment.
    /// - Parameter segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    /// - Returns: Returns the view model assigned to the receiver as content. If no title has been set, it returns nil.
    public func viewModelForSegment(at segment: Int) -> InformerTab? {
        guard let item = textItems[safe: segment] else { return nil }
        return InformerTab(title: item.title, subtitle: item.subtitle)
    }
    
    /// Removes all segments of the receiver
    public func removeAllItems() {
        removeAllViews()
    }
    
    // MARK: - AppThemeable
    
    public func apply(theme: AppTheme) {
        textItems.forEach() { $0.apply(theme: theme) }
        scheme = InformerSegmentedScheme(theme: theme)
    }
    
    // MARK: - Internal Mehtods
    
    func updateScheme() {
        textItems.forEach() { $0.scheme = scheme }
        configure(for: state)
    }
    
    override func configure(for state: UIControl.State) {
        super.configure(for: state)
    }
 
    // MARK: - Private Methods

    private func commonInit() {
        height = Constants.height
        apply(theme: defaultTheme)
    }
    
    private func createItem(item: InformerTab) -> InformerSegmentedView {
        let view = InformerSegmentedView()
        view.title = item.title
        view.subtitle = item.subtitle
        view.scheme = scheme
        
        return view
    }
    
}
