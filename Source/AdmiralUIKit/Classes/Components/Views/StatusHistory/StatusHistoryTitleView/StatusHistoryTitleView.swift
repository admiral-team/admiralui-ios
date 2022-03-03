//
//  StatusHistoryTitleView.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralTheme

class StatusHistoryTitleView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    var subtitle: String? {
        didSet { subtitleLabel.text = subtitle }
    }
    
    var scheme = StatusHistoryTitleViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func apply(theme: AppTheme) {
        scheme = StatusHistoryTitleViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        titleLabel.textColor = scheme.titleColor.uiColor
        titleLabel.font = scheme.titleFont.uiFont
        
        subtitleLabel.textColor = scheme.subtitleColor.uiColor
        subtitleLabel.font = scheme.subtitleFont.uiFont
    }
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.numberOfLines = 1
        subtitleLabel.numberOfLines = 0
        
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
    }
    
    private func addSubviews() {
        [titleLabel, subtitleLabel].addToSuperview(self)
    }
    
    private func configureConstraints() {
        let bottomConstraint = bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 3)
        bottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomConstraint
        ])
    }
    
}
