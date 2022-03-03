//
//  BottomSheetPresenter.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// A protocol for objects that will present a view controller as a PanModal

public protocol BottomSheetPresenter: AnyObject {

    ///  A flag that returns true if the current presented view controller is using the BottomSheetPresentationDelegate
    var isBottomSheetPresneted: Bool { get }

    /// Presents a view controller that conforms to the BottomSheetPresentable protocol
    func presentBottomSheet(
        _ viewControllerToPresent: BottomSheetPresentable.LayoutType,
        sourceView: UIView?,
        sourceRect: CGRect,
        completion: (() -> Void)?)

}
