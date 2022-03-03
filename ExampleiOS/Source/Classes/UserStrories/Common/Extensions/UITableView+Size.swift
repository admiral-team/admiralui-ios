//
//  UITableView+Size.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import UIKit

extension UITableView {
    
    func sizeHeaderToFit() {
        guard let headerView = tableHeaderView else { return }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        tableHeaderView = headerView
    }
    
}
