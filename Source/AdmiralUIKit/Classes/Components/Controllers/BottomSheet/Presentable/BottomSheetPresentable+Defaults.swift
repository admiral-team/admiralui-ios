//
//  BottomSheetPresentable+Defaults.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// Default values for the PanModalPresentable.
public extension BottomSheetPresentable where Self: UIViewController {

    var topOffset: CGFloat {
        return topLayoutOffset
    }

    var shortFormHeight: BottomSheetHeight {
        return longFormHeight
    }

    var longFormHeight: BottomSheetHeight {
        guard let scrollView = panScrollable else { return .maxHeight }
        
        scrollView.layoutSubviews()
        return .contentHeight(scrollView.contentSize.height)
    }

    var cornerRadius: CGFloat {
        return LayoutGrid.tripleModule
    }

    var springDamping: CGFloat {
        return 0.8
    }
    
    var transitionDuration: Double {
        return BottomSheetModalAnimator.Constants.defaultTransitionDuration
    }

    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState]
    }

    var scrollIndicatorInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top: CGFloat(cornerRadius),
            left: 0,
            bottom: bottomLayoutOffset,
            right: 0)
    }

    var anchorModalToLongForm: Bool {
        return false
    }
    
    var allowsDragToDismiss: Bool {
        return true
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }

    var allowsExtendedPanScrolling: Bool {
        guard let scrollView = panScrollable else { return false }

        scrollView.layoutIfNeeded()
        return scrollView.contentSize.height > (scrollView.frame.height - bottomLayoutOffset)
    }

    var isUserInteractionEnabled: Bool {
        return true
    }
    
    func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return true
    }

    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) {

    }

    func shouldTransition(to state: BottomSheetPresentationState) -> Bool {
        return true
    }

    func shouldPrioritize(panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return false
    }

    func willTransition(to state: BottomSheetPresentationState) {

    }

    func panModalWillDismiss() {

    }

    func panModalDidDismiss() {

    }
    
}
