//
//  SeparatorView.swift
//  AdmiralUI
//
//  Created on 15.10.2020.
//

import UIKit

/// Line mode.
enum SeparatorLineMode {
    /// Solid mode used to draw single solid line.
    case solid
    /// Dased mode used to draw dash line.
    case dashed(dash: CGFloat, gap: CGFloat, phase: CGFloat)
}

/// Line positon.
enum SeparatorLinePosition {
    /// Draw line on the top.
    case top
    /// Draw line on the bottom.
    case bottom
    /// Draw line on the center.
    case center
}


/// The separator view class can be used for drawing custom separators with different styles.
final class SeparatorView: UIView {
    
    // MARK: - Public Properties
    
    /// The view's line Color.
    var lineColor: UIColor = .black {
        didSet { updateLineColor() }
    }
    
    /// The view's line mode.
    var lineMode: SeparatorLineMode = .solid {
        didSet { updateLineMode() }
    }
    
    /// The view's line position.
    var linePosition: SeparatorLinePosition = .top {
        didSet { updateLineMode() }
    }
    
    /// The view's line width.
    var lineWidth: CGFloat = 2.0 {
        didSet { updateLineWidth() }
    }
        
    // MARK: - Public Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        switch lineMode {
        case .solid:
            drawSolidLine(
                context: context,
                rect: rect,
                width: lineWidth,
                position: linePosition,
                color: lineColor)
        case .dashed(let dash, let gap, let phase):
            drawDashLine(
                context: context,
                rect: rect,
                width: lineWidth,
                position: linePosition,
                dash: dash,
                gap: gap,
                phase: phase,
                color: lineColor)
        }
    }
    
    // MARK: - Private Methods
    
    private func drawSolidLine(
        context: CGContext,
        rect: CGRect,
        width: CGFloat,
        position: SeparatorLinePosition,
        color: UIColor
    ) {
        let bezierPath = createLine(rect: rect, width: width, position: linePosition)
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        context.addPath(bezierPath.cgPath)
        context.strokePath()
    }
        
    private func drawDashLine(
        context: CGContext,
        rect: CGRect,
        width: CGFloat,
        position: SeparatorLinePosition,
        dash: CGFloat,
        gap: CGFloat,
        phase: CGFloat,
        color: UIColor
    ) {
        let bezierPath = createLine(rect: rect, width: width, position: linePosition)
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        context.addPath(bezierPath.cgPath)
        context.setLineDash(phase: phase, lengths: [dash, gap])
        context.strokePath()
    }
    
    private func createLine(rect: CGRect, width: CGFloat, position: SeparatorLinePosition) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let startPoint: CGPoint
        let endPoint: CGPoint
        
        switch position {
        case .top:
            startPoint = CGPoint(x: 0, y: width / 2)
            endPoint = CGPoint(x: rect.width, y: width / 2)
        case .bottom:
            startPoint = CGPoint(x: 0, y: rect.height - width / 2)
            endPoint = CGPoint(x: rect.width, y: rect.height - width / 2)
        case .center:
            startPoint = CGPoint(x: 0, y: rect.height / 2)
            endPoint = CGPoint(x: rect.width, y: rect.height / 2)
        }
        
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
                
        return bezierPath
    }
    
    private func updateLineMode() {
        setNeedsDisplay()
    }
    
    private func updateLineColor() {
        setNeedsDisplay()
    }
    
    private func updateLineWidth() {
        invalidateIntrinsicContentSize()
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    private func updateLinePosition() {
        setNeedsDisplay()
    }
    
}
