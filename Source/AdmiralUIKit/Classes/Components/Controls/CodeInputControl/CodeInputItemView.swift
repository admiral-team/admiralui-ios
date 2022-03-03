//
//  CodeInputItem.swift
//  AdmiralUI
//
//  Created on 03.11.2020.
//

import UIKit

/// Protocol of custom item that is used by CodeInputControl.
protocol CodeInputItemView: UIView {
    /// The input item text. In common case that will be one character.
    var text: String? { get set }
    
    /// The property that indicate is control focused and user interacts with it.
    var isOnFocus: Bool { get set }
    
    /// The control status.
    var status: CodeInputControl.Status { get set }
    
    /// The control style.
    var style: CodeInputControl.Style { get set }
}
