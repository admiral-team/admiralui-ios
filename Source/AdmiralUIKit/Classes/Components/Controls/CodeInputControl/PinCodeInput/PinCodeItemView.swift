//
//  PinView.swift
//  AdmiralUI
//
//  Created on 03.11.2020.
//

import UIKit
import AdmiralTheme

struct PinViewTheme {

    struct Background {
        let `default`: AColor
        let active: AColor
        let positive: AColor
        let error: AColor
    }

    let backgroundColor: Background

}

/// Single pin circle that can be displayed by CodeInputControl.
class PinCodeItemView: UIView, CodeInputItemView {
    
    // MARK: - Internal Properties
    
    var text: String?
    var isOnFocus: Bool = false
    var style: CodeInputControl.Style = .default
    var status: CodeInputControl.Status = .normal
    
    open override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
        
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        if let layer = layer as? CAShapeLayer {
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        round()
    }
    
    func round() {
        layer.cornerRadius = frame.width / 2.0
    }
    
    
    func apply(theme: PinViewTheme) {
        switch status {
        case .normal:
            let isEmpty = (text ?? "").isEmpty
            if !isEmpty {
                backgroundColor = theme.backgroundColor.active.uiColor
            } else {
                backgroundColor = theme.backgroundColor.default.uiColor
            }
        case .success:
            backgroundColor = theme.backgroundColor.positive.uiColor
        case .error:
            backgroundColor = theme.backgroundColor.error.uiColor
        }
    }

}
