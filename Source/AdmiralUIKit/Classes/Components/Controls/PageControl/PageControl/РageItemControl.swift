//
//  РageItemControl.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit

class РageItemControl: UIControl {
    
    // MARK: - Internal Properties
    
    override var isSelected: Bool {
        didSet { configure(for: state) }
    }
    
    override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    override var isHighlighted: Bool {
        didSet { configure(for: state) }
    }
    
    var scheme = PageControlViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: LayoutGrid.doubleModule,
            height: LayoutGrid.halfModule)
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = LayoutGrid.halfModule / 2
        configure(for: state)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule),
            widthAnchor.constraint(equalToConstant: LayoutGrid.doubleModule)
        ])
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }
    
    private func updateScheme() {
        configure(for: state)
    }
    
}
