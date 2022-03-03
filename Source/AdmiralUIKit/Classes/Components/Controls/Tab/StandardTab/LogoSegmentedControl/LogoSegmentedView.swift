//
//  LableSegmentedView.swift
//  AdmiralUI
//
//  Created on 27.10.2020.
//

import UIKit

final class LogoSegmentedView: UIControl, SegmentControlItem {
    
    // MARK: - Internal Properties
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    override var isSelected: Bool {
        didSet { configure(for: state) }
    }
    
    override var isHighlighted: Bool {
        didSet { configure(for: state) }
    }
    
    override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    var separatorColor: UIColor? {
        get { return separatorView.backgroundColor }
        set { separatorView.backgroundColor = newValue }
    }
    
    var isSeparatorHidden: Bool {
        get { return separatorView.isHidden }
        set { separatorView.isHidden = newValue }
    }
    
    var scheme = LogoSegmentedScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
        
    private let separatorView = UIView()
    private let imageView = UIImageView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        configureUI()
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        [imageView, separatorView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 1.0),
            separatorView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            separatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureUI() {
        imageView.contentMode = .center
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        separatorView.backgroundColor = scheme.itemScheme.borderColor.parameter(for: state)?.uiColor
        imageView.alpha = scheme.itemScheme.alpha.parameter(for: state) ?? 1.0
    }
    
    private func updateScheme() {
        configure(for: state)
    }
    
}
