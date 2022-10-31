//
//  TextTabSegmentControl.swift
//  AdmiralUI
//
//  Created on 27.10.2020.
//

import UIKit
import AdmiralTheme

/// A horizontal control that consists of multiple segments, each segment functioning as a discrete text button.
public class StandardSegmentedControl: PlainSegmentedControl, AnyAppThemable {
    
    public override var selectedSegmentIndex: Int {
        didSet { configureThumbView() }
    }

    public override var accessibilityIdentifier: String? {
        didSet {
            guard let id = accessibilityIdentifier else {
                return
            }
            for i in 0..<items.count {
                textItems[i].accessibilityIdentifier = "\(id)\(i)"
            }

        }
    }
    
    // MARK: - Internal Properties
    
    var scheme = StandardSegmentedScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var textItems: [StandardSegmentedView] {
        return items as? [StandardSegmentedView] !! fatalError("This is not TextTabSegmentView class")
    }
            
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with titles.
    public convenience init(titles: [String?]) {
        self.init(frame: .zero)
        setTitles(titles)
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
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        self.scheme = StandardSegmentedScheme(theme: theme)
    }
        
    // MARK: - Internal Methods
    
    override func configure(for state: UIControl.State) {
        super.configure(for: state)
        
        contentView.layer.borderColor = scheme.borderColor.parameter(for: state)?.cgColor
        thumbView.layer.borderColor = scheme.thumbColor.parameter(for: state)?.cgColor
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        height = LayoutGrid.quadrupleModule
        addTarget(self, action: #selector(segmentIndexChange), for: .valueChanged)
    }
    
    @objc private func segmentIndexChange() {
        configureThumbView()
    }
    
    private func configureThumbView() {
        guard let view = textItems[safe: selectedSegmentIndex] else { return }
        
        let state: UIControl.State = view.isEnabled ? .selected : [.selected, .disabled]
        thumbView.layer.borderColor = scheme.thumbColor.parameter(for: state)?.cgColor
    }
    
    private func createItem(title: String?) -> StandardSegmentedView {
        let item = StandardSegmentedView()
        item.title = title
        item.scheme = scheme

        return item
    }
    
    private func updateScheme() {
        textItems.forEach() { $0.scheme = scheme }
        configure(for: state)
    }
    
}
