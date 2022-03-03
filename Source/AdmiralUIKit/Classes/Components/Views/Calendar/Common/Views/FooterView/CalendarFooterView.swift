//
//  CalendarFooterView.swift
//  AdmiralUI
//
//  Created on 19.11.2020.
//

import UIKit
import AdmiralTheme

class CalendarFooterView: UICollectionReusableView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var scheme = CalendarFooterViewColorScheme() {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private let separatorView = UIView()
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CalendarFooterViewColorScheme(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: .default)
        
        addSubviews()
        setupViews()
    }
    
    private func addSubviews() {
        addSubview(separatorView)
    }
    
    private func setupViews() {
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(fillView(view: separatorView))
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        separatorView.backgroundColor = scheme.separatorViewBackgroundColor.uiColor
    }
    
}
