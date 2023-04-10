//
//  StatusHistoryDateView.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

protocol StatusHistoryDateViewDelegate: AnyObject {
    func didTapClose()
}

class StatusHistoryDateView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    weak var delegate: StatusHistoryDateViewDelegate?
    
    var dateText: String? {
        didSet { dateLabel.text = dateText }
    }
    
    var scheme = StatusHistoryDateViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let dateLabel = UILabel()
    private let closeButton = UIButton()
    
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
        scheme = StatusHistoryDateViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        closeButton.setImage(Asset.Service.Outline.closeOutline.image, for: .normal)
    }
    
    @objc private func tapClose() {
        delegate?.didTapClose()
    }
    
    private func addSubviews() {
        [dateLabel, closeButton].addToSuperview(self)
    }
    
    private func updateScheme() {
        dateLabel.textColor = scheme.textColor.uiColor
        dateLabel.font = scheme.textFont.uiFont
        
        closeButton.tintColor = scheme.buttonTintColor.uiColor
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            closeButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 3),
            closeButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 3),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 13)
        ])
    }
    
}
