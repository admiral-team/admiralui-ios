//
//  ScrollablePager.swift
//  AdmiralUI
//
//  Created on 13.01.2021.
//

import UIKit
import AdmiralTheme

public class ScrollablePageControl: UIView, AppThemeable {
    
    // MARK: - Internal Properties
    
    /// Returns the current selected page of pafge control
    public private(set) var currentPage: Int = 0
    
    /// The total number of pages of page control
    public var numberOfPages: Int = 0 {
        didSet {
            scrollView.isHidden = (numberOfPages <= 1 && hidesForSinglePage)
            displayCount = min(displayedItems, numberOfPages)
            update(currentPage: currentPage)
        }
    }
    
    /// The boolean valued indicates if page control isHidden if numberOfPages == 0
    public var hidesForSinglePage: Bool = false {
        didSet {
            scrollView.isHidden = (numberOfPages <= 1 && hidesForSinglePage)
        }
    }
    
    /// The number of page control items that are currently displayed
    public var displayedItems: Int = 6
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: itemSize * CGFloat(displayCount), height: itemSize)
    }
    
    var scheme = PageControlViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Propeties
    
    private enum Direction {
        case left
        case right
        case stay
    }
    
    private enum Constants {
        static let dotHeight: CGFloat = 4.0
        static let dotWidth: CGFloat = 16.0
        static let dotSpace: CGFloat = 4.0
        static let animateDuration: TimeInterval = 0.3
    }
    
    private let scrollView = UIScrollView()
    private var itemSize: CGFloat {
        return Constants.dotWidth + Constants.dotSpace
    }
    private var items: [ScrollablePageItemControl] = []
    private var displayCount: Int = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Initilizers
    
    public init() {
        super.init(frame: .zero)
        
        commonInit()
        updateViewSize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
        updateViewSize()
    }
    
    // MARK: - Life Cycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    // MARK: - Public Methods
    
    public func setCurrentPage(at currentPage: Int, animated: Bool = true) {
        guard
            (currentPage < numberOfPages && currentPage >= 0),
            currentPage != self.currentPage
        else {
            return
        }
        
        scrollView.layer.removeAllAnimations()
        updateDot(at: currentPage, animated: animated)
        self.currentPage = currentPage
    }
    
    // MARK: - App Themable
    
    public func apply(theme: AppTheme) {
        scheme = PageControlViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        backgroundColor = .clear
        
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
    }
    
    private func updateScheme() {
        items.forEach() { $0.scheme = scheme }
    }
    
    private func update(currentPage: Int) {
        if currentPage < displayCount {
            items = (-2..<(displayCount + 2))
                .map { ScrollablePageItemControl(itemSize: itemSize, index: $0) }
        } else {
            guard
                let firstItem = items.first,
                let lastItem = items.last
            else {
                return
            }
            
            items = (firstItem.index...lastItem.index)
                .map { ScrollablePageItemControl(itemSize: itemSize, index: $0) }
        }
        
        scrollView.contentSize = .init(width: itemSize * CGFloat(numberOfPages), height: itemSize)
        
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        items.forEach { scrollView.addSubview($0) }
        
        let size: CGSize = .init(width: itemSize * CGFloat(displayCount), height: itemSize)
        
        scrollView.bounds.size = size
        scrollView.contentInset = .zero
        
        updateDot(at: currentPage, animated: false)
    }
    
    private func updateViewSize() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func updateDot(at currentPage: Int, animated: Bool) {
        if numberOfPages > displayCount {
            updateDotPosition(currentPage: currentPage, animated: animated)
            updateDotColor(currentPage: currentPage)
            updateDotSize(currentPage: currentPage, animated: animated)
        }
    }
    
    private func updateDotColor(currentPage: Int) {
        items.forEach {
            $0.isSelected = ($0.index == currentPage) ?
                true : false
        }
    }
    
    private func updateDotPosition(currentPage: Int, animated: Bool) {
        let duration = animated ? Constants.animateDuration : 0
        
        if currentPage == 0 {
            let x = -scrollView.contentInset.left
            moveScrollView(x: x, duration: duration)
        } else if currentPage == numberOfPages - 1 {
            let x = scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right
            moveScrollView(x: x, duration: duration)
        } else if CGFloat(currentPage) * itemSize <= scrollView.contentOffset.x {
            let x = scrollView.contentOffset.x - itemSize
            moveScrollView(x: x, duration: duration)
        } else if CGFloat(currentPage) * itemSize + itemSize >=
                    scrollView.contentOffset.x + scrollView.bounds.width {
            let x = scrollView.contentOffset.x + itemSize
            moveScrollView(x: x, duration: duration)
        }
    }
    
    private func updateDotSize(currentPage: Int, animated: Bool) {
        let duration = animated ? Constants.animateDuration : 0
        
        items.forEach { item in
            item.animateDuration = duration
            if item.index == currentPage {
                item.sizeState = .normal
            } else if item.index < 0 {
                item.sizeState = .smallLeft
            } else if item.index >= numberOfPages - 1 {
                item.sizeState = .normal
            } else if item.frame.maxX >= scrollView.contentOffset.x + scrollView.bounds.width {
                item.sizeState = .smallRight
            } else if scrollView.contentOffset.x > 0 && item.frame.minX <= scrollView.contentOffset.x {
                item.sizeState = .smallLeft
            } else {
                item.sizeState = .normal
            }
        }
    }
    
    private func moveScrollView(x: CGFloat, duration: TimeInterval) {
        let direction = behaviorDirection(x: x)
        reusedView(direction: direction)
        UIView.animate(withDuration: duration, animations: { [unowned self] in
            self.scrollView.contentOffset.x = x
        })
    }
    
    private func behaviorDirection(x: CGFloat) -> Direction {
        switch x {
        case let x where x > scrollView.contentOffset.x:
            return .right
        case let x where x < scrollView.contentOffset.x:
            return .left
        default:
            return .stay
        }
    }
    
    private func reusedView(direction: Direction) {
        guard
            let firstItem = items.first,
            let lastItem = items.last
        else {
            return
        }
        
        switch direction {
        case .left:
            lastItem.index = firstItem.index - 1
            lastItem.frame = CGRect(
                x: CGFloat(lastItem.index) * itemSize,
                y: 0,
                width: Constants.dotWidth,
                height: Constants.dotHeight)
            items.insert(lastItem, at: 0)
            items.removeLast()
        case .right:
            firstItem.index = lastItem.index + 1
            firstItem.frame = CGRect(
                x: CGFloat(firstItem.index) * itemSize ,
                y: 0,
                width: itemSize,
                height: itemSize)
            items.insert(firstItem, at: items.count)
            items.removeFirst()
        case .stay:
            break
        }
    }
    
}
