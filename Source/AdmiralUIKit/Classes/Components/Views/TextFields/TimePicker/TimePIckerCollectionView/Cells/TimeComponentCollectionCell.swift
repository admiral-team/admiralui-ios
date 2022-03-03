//
//  TimeComponentCollectionCell.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit

class TimeComponentCollectionCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var text: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    var textColor: UIColor {
        get { return label.textColor }
        set { label.textColor = newValue }
    }
    
    var font: UIFont {
        get { return label.font }
        set { label.font = newValue }
    }
    
    var textAlignment: NSTextAlignment {
        get { return label.textAlignment }
        set { label.textAlignment = newValue }
    }
    
    // MARK: - Private Properties
    
    private let label = UILabel()
    
    // MARK: - LifeCycle
    
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
        label.frame = bounds
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubview(label)
    }
    
}
