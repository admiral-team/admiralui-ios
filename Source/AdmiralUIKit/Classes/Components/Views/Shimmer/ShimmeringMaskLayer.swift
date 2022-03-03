//
//  ShimmeringMaskLayer.swift
//  AdmiralUI
//
//  Created on 16.12.2020.
//

import UIKit

final class ShimmeringMaskLayer: CAGradientLayer {

    // MARK: - Internal Properties
    
    let fadeLayer = CALayer()

    // MARK: - Initializer
    
    override init() {
        super.init()
        fadeLayer.backgroundColor = UIColor.white.cgColor
        addSublayer(fadeLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(layer: Any) {

        if let layer = layer as? ShimmeringMaskLayer {
            layer.fadeLayer.backgroundColor = UIColor.white.cgColor
        }

        super.init(layer: layer)
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        let rect = bounds
        fadeLayer.bounds = rect
        fadeLayer.position = CGPoint(x: rect.midX, y: rect.midY)
    }
}
