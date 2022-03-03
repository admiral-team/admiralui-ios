//
//  ScrollablePageItemControl.swift
//  AdmiralUI
//
//  Created on 13.01.2021.
//

import UIKit

class ScrollablePageItemControl: UIControl {
    
    // MARK: - Internal Properties
    
    enum SizeState {
        case none
        case smallLeft
        case smallRight
        case normal
    }
    
    var index: Int
    
    var sizeState: SizeState = .normal {
        didSet { updateDotSize(state: sizeState) }
    }
    
    var animateDuration: TimeInterval = 0.3
    var scheme = PageControlViewScheme() {
        didSet { updateScheme() }
    }
    
    override var isSelected: Bool {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties
    
    private let dotView = UIView()
    private let itemSize: CGFloat
    private let dotHeight: CGFloat = LayoutGrid.halfModule
    private let dotWidth: CGFloat = LayoutGrid.doubleModule
    private let smallSizeRatio: CGFloat = 0.5
    
    // MARK: - Initializers
    
    init(itemSize: CGFloat, index: Int) {
        self.itemSize = itemSize
        self.index = index
        
        let x = itemSize * CGFloat(index)
        let frame = CGRect(x: x, y: 0, width: itemSize, height: itemSize)
        
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(dotView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotView.layer.cornerRadius = dotHeight / 2
        dotView.layer.masksToBounds = true
    }
    
    // MARK: - Private Methods

    private func configure(for state: UIControl.State) {
       
    }
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func updateDotSize(state: SizeState) {
        UIView.animate(withDuration: animateDuration, animations: { [unowned self] in
            var size: CGSize
            let smallDotWidth = self.dotWidth * self.smallSizeRatio
            
            switch self.sizeState {
            case .normal:
                size = CGSize(
                    width: dotWidth,
                    height: dotHeight)
                self.dotView.center = CGPoint(
                    x: self.itemSize / 2,
                    y: self.itemSize / 2)
            case .smallRight:
                size = CGSize(
                    width: smallDotWidth,
                    height: self.dotHeight
                )
                self.dotView.center = CGPoint(
                    x: self.itemSize / 2 - LayoutGrid.halfModule,
                    y: self.itemSize / 2)
            case .smallLeft:
                size = CGSize(
                    width: smallDotWidth,
                    height: self.dotHeight
                )
                self.dotView.center = CGPoint(
                    x: self.itemSize / 2 + LayoutGrid.halfModule,
                    y: self.itemSize / 2)
            case .none:
                size = .zero
            }
            self.dotView.layer.bounds.size = size
            self.dotView.backgroundColor = scheme.backgroundColor.parameter(for: self.state)?.uiColor
        })
    }
    
}
