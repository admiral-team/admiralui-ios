//
//  UIView+DefalutHighlight.swift
//  ExampleiOS
//
//  Created on 20.02.2021.
//

import UIKit

extension UIView {
    
    func setDefaultHighlighted(_ highlighted: Bool, animated: Bool) {
        let newAlpha: CGFloat = highlighted ? 0.5 : 1
        
        guard animated else {
            alpha = newAlpha
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = newAlpha
        }
    }
    
}
