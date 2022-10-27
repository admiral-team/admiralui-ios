//
//  FeedbackInput.swift
//  AdmiralUI
//
//  Created on 03.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources


/// An object for evaluating.
open class FeedbackInputControl: UIControl, AnyAppThemable {

    // MARK: - Constants
    
    private enum Constants {
        static let duration: TimeInterval = Durations.Default.single
        static let starImage = Asset.System.Solid.starSolid.image
    }
    
    // MARK: - Public Properties
    
    /// Number of items in control.
    open var itemsCount = 5 {
        willSet { prepareViews(elementsCount: newValue) }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open override var isEnabled: Bool {
        didSet { updateColors() }
    }

    /// Color scheme.
    open var scheme = FeedBackInputScheme() {
        didSet { updateScheme() }
    }
        
    // MARK: - Internal Properties
    
    var itemViews = [UIImageView]()
    var parameters = Layout.Parameters()
    
    var cursorPosition = 0 {
        didSet { updateColorsAnimated() }
    }

    // MARK: - Initializers
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Called when a touch event enters the control’s bounds.
    ///   - touch: The touch object containing updated information.
    ///   - event: The event object containing the touch event.
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        viewTracking(touch.location(in: self))
        return true
    }
    
    /// Called when a touch event for the control updates.
    /// - Parameters:
    ///   - touch: The touch object containing updated information.
    ///   - event: The event object containing the touch event.
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        viewTracking(touch.location(in: self))
        return true
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        self.scheme = FeedBackInputScheme(theme: theme)
    }

    func updateColorsAnimated() {
        UIView.animate(
            withDuration: Constants.duration,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.updateColors()
            }, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        prepareViews(elementsCount: itemsCount)
    }
    
    private func viewTracking(_ location: CGPoint) {
        for view in itemViews {
            if view.frame.contains(location) {
                cursorPosition = view.tag
            }
        }
        sendActions(for: .valueChanged)
    }
    
    private func updateColors() {
        for index in 0..<itemViews.count {
            let isSelected = index <= cursorPosition
            let selectedColor = scheme.selectedColor.parameter(for: state)
            let defaultColor = scheme.defaultColor.parameter(for: state)
            itemViews[index].tintColor = isSelected ? selectedColor?.uiColor : defaultColor?.uiColor
        }
    }
    
    private func prepareViews(elementsCount: Int) {
        let count = itemViews.count
        
        if elementsCount > count {
            for i in count..<elementsCount {
                let view = UIImageView(image: Constants.starImage)
                view.tag = i
                
                addSubview(view)
                itemViews.append(view)
            }
            updateColors()
            
        } else if elementsCount < count {
            var tmpCount = count
            
            for i in elementsCount..<tmpCount {
                itemViews[i].removeFromSuperview()
                itemViews.remove(at: i)

                tmpCount -= 1
            }
            
            cursorPosition = min(cursorPosition, tmpCount)
        }
    }
    
    private func updateScheme() {
        updateColors()
    }
    
    // MARK: - Layout
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(frame.size)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let count = itemViews.count
        let itemSize = parameters.itemSize
        let minSpacing = parameters.minSpacing
        
        let width = itemSize.width * CGFloat(count) + CGFloat(max(0, count - 1)) * minSpacing
        
        return CGSize(width: width, height: itemSize.height)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let result = calculateLayout(size: frame.size)
        result.itemViews.enumerated().forEach { itemViews[$0.offset].frame = $0.element }
        
        invalidateIntrinsicContentSize()
    }

}


// MARK: - Layout

extension FeedbackInputControl {

    struct Layout {
        struct Parameters {
            var itemSize = CGSize(width: 24, height: 24)
            var minSpacing: CGFloat = 12
        }
        struct Frames {
            var spacing: CGFloat
            var itemViews: [CGRect]
        }
    }

    func calculateLayout(size: CGSize) -> Layout.Frames {
        let count = itemViews.count
        let itemSize = parameters.itemSize
        let minSpacing = parameters.minSpacing

        var spacing: CGFloat = 0

        if count > 1 {
            spacing = max((size.width - CGFloat(count) * itemSize.width) / (CGFloat(count) - 1), minSpacing)
        }

        var frames = [CGRect]()
        var offsetX: CGFloat = 0

        for _ in 0..<count {
            let frame = CGRect(x: offsetX, y: 0, width: itemSize.width, height: itemSize.height)
            offsetX += itemSize.width + spacing

            frames.append(frame)
        }

        return Layout.Frames(spacing: spacing, itemViews: frames)
    }

}
