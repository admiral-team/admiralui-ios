//
//  UIView+Hidden.swift
//  ExampleiOS
//
//  Created on 24.03.2021.
//

import UIKit

extension UIView {
    
    func setIsHidden(_ hidden: Bool, animated: Bool) {
        if animated {
            if self.isHidden && !hidden {
                self.alpha = 0.0
                self.isHidden = false
            }
    
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: {
                self.alpha = hidden ? 0.0 : 1.0
            }) { _ in // swiftlint:disable:this multiple_closures_with_trailing_closure
                self.isHidden = hidden
            }
        } else {
            self.isHidden = hidden
        }
    }
    
}
