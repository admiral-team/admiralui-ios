//
//  StatusHistoryStatusView.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralTheme

class StatusHistoryStatusView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var status: StatusHistory = .hold {
        didSet { updateScheme() }
    }
    
    var statusText: String? {
        didSet { statusLabel.text = statusText }
    }
    
    var statusImage = UIImage() {
        didSet { statusImageView.image = statusImage }
    }
    
    var scheme = StatusHistoryStatusViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var statusLabel = UILabel()
    private var statusImageView = UIImageView()
    
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
        scheme = StatusHistoryStatusViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        statusImageView.contentMode = .scaleAspectFit
    }
    
    private func addSubviews() {
        [statusLabel, statusImageView].addToSuperview(self)
    }
    
    private func updateScheme() {
        statusLabel.textColor = scheme.textColor.parameter(for: status)?.uiColor
        statusLabel.font = scheme.textFont.uiFont
        statusImageView.tintColor = scheme.imageTintColor.parameter(for: status)?.uiColor
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: LayoutGrid.doubleModule),
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 5),
            trailingAnchor.constraint(greaterThanOrEqualTo: statusLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: LayoutGrid.module),
            
            statusImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            statusImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            statusImageView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.module * 9)
        ])
    }
    
    
}
