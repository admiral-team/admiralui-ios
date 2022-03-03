//
//  UIView+BottomSheet.swift
//  AdmiralUI
//
//  Created on 20.01.2021.
//

import UIKit

extension UIView {
    
    var panContainerView: BottomSheetContainerView? {
        return subviews.first(where: { view -> Bool in
            view is BottomSheetContainerView
        }) as? BottomSheetContainerView
    }
    
}
