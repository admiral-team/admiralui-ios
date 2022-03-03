//
//  BottomSheetHeight.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// An enum that defines the possible states of the height of a pan modal container view
/// for a given presentation state (shortForm, longForm)
public enum BottomSheetHeight: Equatable {
    
    /// Sets the height to be the maximum height (+ topOffset)
    case maxHeight
    
    /// Sets the height to be the max height with a specified top inset.
    /// - Note: A value of 0 is equivalent to .maxHeight
    case maxHeightWithTopInset(CGFloat)
    
    /// Sets the height to be the specified content height
    case contentHeight(CGFloat)
    
    /// Sets the height to be the specified content height & also ignores the bottomSafeAreaInset
    case contentHeightIgnoringSafeArea(CGFloat)
    
    /// Sets the height to be the intrinsic content height
    case intrinsicHeight
    
}
