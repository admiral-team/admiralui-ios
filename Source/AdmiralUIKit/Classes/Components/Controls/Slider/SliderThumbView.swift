//
//  SliderThumbView.swift
//  AdmiralUI
//
//  Created on 22.10.2020.
//

import UIKit

// A slider thumb view.
final class SliderThumbView: UIView {
    
    // MARK: - Internal Properties
    
    var isHighlighted: Bool = false
    
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
    }
        
    // MARK: - Public Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2.0
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        layer.masksToBounds = true
        layer.borderWidth = 5.0
    }
    
}
