//
//  BigTabView.swift
//  ExampleiOS
//
//  Created by ADyatkov on 06.11.2020.
//

import UIKit
import AdmiralUI

final class BigTabView: UIView, AnyAppThemable {
    
    // MARK: - Private Properties
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()

    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 120.0)
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        titleLabel.textColor = theme.colors.primary.uicolor
        subTitleLabel.textColor = theme.colors.primary.uicolor
        backgroundColor = theme.colors.neutralSurfaceOne.uicolor
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        [titleLabel,
         subTitleLabel].forEach() {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        subTitleLabel.textAlignment = .center
    }
    
}
