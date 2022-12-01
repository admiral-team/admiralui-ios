//
//  LableSegmentedControl.swift
//  AdmiralUI
//
//  Created on 27.10.2020.
//

import UIKit
import AdmiralTheme

/// Item for Logo  tab.
public struct LogoTabItem {

    // MARK: - Public Properties
    /// Image item.
    public let image: UIImage?

    /// The accesibility identifier
    public var accesibilityId: String?

    // MARK: - Initializer
    public init(image: UIImage?, accesibilityId: String? = nil) {
        self.image = image
        self.accesibilityId = accesibilityId
    }

}

/// A horizontal control that consists of multiple segments, each segment functioning as a discrete image button.
public class LogoTab: PlainSegmentedControl, AnyAppThemable {
    
    public override var selectedSegmentIndex: Int {
        didSet { configureThumbView() }
    }

    /// Color scheme.
    public var scheme = LogoSegmentedScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var imageItems: [LogoSegmentedView] {
        return items as? [LogoSegmentedView] !! fatalError("This is not LogoSegmentedView class")
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with images.
    public convenience init(items: [LogoTabItem?]) {
        self.init(frame: .zero)
        setItems(items)
        commonInit()
    }

    /// Initializes and returns a newly allocated view object with images.
    public convenience init(images: [UIImage?]) {
        self.init(frame: .zero)
        setItems(images.map { .init(image: $0) })
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
    
    /// Sets images.
    /// - Parameter images: A images to display in the segments.
    public func setItems(_ items: [LogoTabItem?]) {
        let items = items.map({ createItem(item: $0) })
        set(items: items)
    }

    /// Inserts a segment at a specific position in the receiver and gives it a image as content.
    /// - Parameters:
    ///   - image: A image to use as the segment’s image.
    ///   - segment: An index number identifying a segment in the control.
    public func insertImage(_ image: UIImage?, forSegmentAt segment: Int) {
        let view = createItem(item: .init(image: image))
        insert(item: view, at: segment)
    }
    /// Remove a segment at a specific position.
    /// - Parameter segment: An index number identifying a segment in the control.
    public func removeImage(forSegmentAt segment: Int) {
        guard let item = imageItems[safe: segment] else { return }
        remove(view: item, at: segment)
    }
    
    /// Sets the enable state of a segment.
    /// - Parameters:
    ///   - isEnabled: A Boolean value indicating whether the control is in the enabled state.
    ///   - segment:  An index number identifying a segment in the control.
    public func setEnabled(_ isEnabled: Bool, forSegmentAt segment: Int) {
        imageItems[safe: segment]?.isEnabled = isEnabled
        configureThumbView()
    }
    
    /// Sets the content of a segment to a given image.
    /// - Parameters:
    ///   - image: An image object to display in the segment.
    ///   - segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    public func setImage(_ image: UIImage?, forSegmentAt segment: Int) {
        imageItems[safe: segment]?.image = image
    }
    
    /// Returns the image for a specific segment.
    /// - Parameter segment: An index number identifying a segment in the control. It must be a number between 0 and the number of segments (numberOfSegments) minus 1; values exceeding this upper range are pinned to it.
    public func imageForSegment(at segment: Int) -> UIImage? {
        return imageItems[safe: segment]?.image
    }
    
    // MARK: - AppThemeable

    public func apply(theme: AppTheme) {
        self.scheme = LogoSegmentedScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    override func configure(for state: UIControl.State) {
        super.configure(for: state)
        
        contentView.layer.borderColor = scheme.borderColor.parameter(for: state)?.cgColor
        thumbView.layer.borderColor = scheme.thumbColor.parameter(for: state)?.cgColor
        addTarget(self, action: #selector(segmentIndexChange), for: .valueChanged)
    }
    
    @objc private func segmentIndexChange() {
        configureThumbView()
    }
    
    private func configureThumbView() {
        guard let view = imageItems[safe: selectedSegmentIndex] else { return }
        
        let state: UIControl.State = view.isEnabled ? .selected : [.selected, .disabled]
        thumbView.layer.borderColor = scheme.thumbColor.parameter(for: state)?.cgColor
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        height = LayoutGrid.doubleModule * 3
        apply(theme: defaultTheme)
    }
    
    private func createItem(item: LogoTabItem?) -> LogoSegmentedView {
        let logoSegmentView = LogoSegmentedView()
        logoSegmentView.image = item?.image
        logoSegmentView.accessibilityIdentifier = item?.accesibilityId
        logoSegmentView.scheme = scheme
        return logoSegmentView
    }
    
    private func updateScheme() {
        imageItems.forEach() { $0.scheme = scheme }
        configure(for: state)
    }

}
