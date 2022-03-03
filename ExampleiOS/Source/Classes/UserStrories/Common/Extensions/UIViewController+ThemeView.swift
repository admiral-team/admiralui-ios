//
//  UIViewController+Theme.swift
//  ExampleiOS
//
//  Created on 12.07.2021.
//

import UIKit
import AdmiralUIKit

extension UIViewController {
    
    func addThemeSwitchView(_ themeView: ThemeSwitchView, to view: UIView? = nil) {
        let superView = view ?? self.view !! fatalError("No view")
        [themeView].addToSuperview(superView)
        
        NSLayoutConstraint.activate([
            superView.trailingAnchor.constraint(equalTo: themeView.trailingAnchor, constant: LayoutGrid.doubleModule),
            themeView.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: LayoutGrid.doubleModule),
            superView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: themeView.bottomAnchor, constant: LayoutGrid.halfModule * 6)
        ])
    }
    
}
