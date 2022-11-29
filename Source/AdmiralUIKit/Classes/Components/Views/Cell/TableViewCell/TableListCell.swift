//
//  TableListCell.swift
//  AdmiralUI
//
//  Created on 24.12.2020.
//

import UIKit
import AdmiralTheme

open class TableListCell<I, L, T>: UITableViewCell, AnyAppThemable where L: CenterListViewComponent,
                                                                         T: TralingListViewComponent,
                                                                         I: LeadingListViewComponent,
                                                                         L: AnyAppThemable,
                                                                         T: AnyAppThemable,
                                                                         I: AnyAppThemable {
    
    // MARK: - Publiс Properties
    
    open var listCell: ListCell<I, L, T>? {
        willSet {
            guard let listCell = listCell else { return }
            listCell.removeFromSuperview()
        }
        didSet {
            commonInit()
        }
    }
    
    open override var isSelected: Bool {
        willSet {
            super.isSelected = isSelected
        } didSet {
            guard selectionStyle != .none else { return }
            
            listCell?.isHighlighted = isSelected
        }
    }
    
    open var isEnabled: Bool = true {
        didSet { listCell?.isEnabled = isEnabled }
    }

    /// Color scheme.
    open var scheme = TableListCellScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = TableListCellScheme(theme: theme)
        listCell?.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        guard let listCell = listCell else { return }
        
        contentView.addSubview(listCell)
        listCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            listCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
