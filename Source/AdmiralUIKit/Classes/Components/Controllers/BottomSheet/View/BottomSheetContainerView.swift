//
//  BottomSheetContainerView.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// A view wrapper around the presented view in a PanModal transition.
class BottomSheetContainerView: UIView {
    
    // MARK: - Initilizers
    
    init(presentedView: UIView, frame: CGRect) {
        super.init(frame: frame)
        addSubview(presentedView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
