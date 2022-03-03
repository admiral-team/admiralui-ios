//
//  BottomSheetPresentable+LayoutHelpers.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// Helper extensions that handle layout in the PanModalPresentationController
extension BottomSheetPresentable where Self: UIViewController {

    var presentedVC: BottomSheetPresentationController? {
        return presentationController as? BottomSheetPresentationController
    }

    var topLayoutOffset: CGFloat {
        guard let rootVC = rootViewController else { return 0 }
        return rootVC.view.safeAreaInsets.top
    }

    /// Length of the bottom layout guide of the presenting view controller.
    /// Gives us the safe area inset from the bottom.
    var bottomLayoutOffset: CGFloat {
        guard let rootVC = rootViewController else { return 0 }
        return rootVC.view.safeAreaInsets.bottom
    }

    /// Returns the short form Y position
    var shortFormYPos: CGFloat {
        guard !UIAccessibility.isVoiceOverRunning else { return longFormYPos }

        let shortFormYPos = topMargin(from: shortFormHeight) + topOffset
        return max(shortFormYPos, longFormYPos)
    }

    /// Returns the long form Y position
    var longFormYPos: CGFloat {
        return max(topMargin(from: longFormHeight), topMargin(from: .maxHeight)) + topOffset
    }

    /// Use the container view for relative positioning as this view's frame
    /// is adjusted in PanModalPresentationController
    var bottomYPos: CGFloat {
        guard let container = presentedVC?.containerView else { return view.bounds.height }
        
        return container.bounds.size.height - topOffset
    }

    /// Converts a given pan modal height value into a y position value
    /// calculated from top of view
    func topMargin(from: BottomSheetHeight) -> CGFloat {
        switch from {
        case .maxHeight:
            return 0.0
        case .maxHeightWithTopInset(let inset):
            return inset
        case .contentHeight(let height):
            return bottomYPos - (height + bottomLayoutOffset)
        case .contentHeightIgnoringSafeArea(let height):
            return bottomYPos - height
        case .intrinsicHeight:
            view.layoutIfNeeded()
            let targetSize = CGSize(
                width: (presentedVC?.containerView?.bounds ?? UIScreen.main.bounds).width,
                height: UIView.layoutFittingCompressedSize.height)
            let intrinsicHeight = view.systemLayoutSizeFitting(targetSize).height
            return bottomYPos - (intrinsicHeight + bottomLayoutOffset)
        }
    }
    
    private var rootViewController: UIViewController? {
        guard
            let application = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as? UIApplication
        else { return nil }

        return application.keyWindow?.rootViewController
    }

}
