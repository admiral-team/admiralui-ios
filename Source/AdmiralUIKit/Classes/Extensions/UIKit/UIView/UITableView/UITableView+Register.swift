//
//  UITableView+Register.swift
//  AdmiralUI
//
//  Created on 13.10.2020.
//

import UIKit

public extension UITableView {
    
    func registerCell(_ viewType: AnyClass, reuseIdentifier: String? = nil, nibName: String? = nil) {
        let sourceBundle = Bundle(for: viewType)
        let reuseIdentifier = reuseIdentifier ?? String(describing: viewType)
        let nibName = nibName ?? reuseIdentifier
        
        if sourceBundle.path(forResource: reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: sourceBundle)
            self.register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            self.register(viewType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func registerSupplementary(_ viewType: AnyClass, reuseIdentifier: String? = nil, nibName: String? = nil) {
        let sourceBundle = Bundle(for: viewType)
        let reuseIdentifier = reuseIdentifier ?? String(describing: viewType)
        let nibName = nibName ?? reuseIdentifier
        
        if sourceBundle.path(forResource: reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: sourceBundle)
            self.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        } else {
            self.register(viewType, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
    }
    
}
