//
//  CustomAlertAction.swift
//  AdmiralUI
//
//  Created on 09.11.2020.
//

import UIKit

/// An action that can be taken when the user taps a button in an alert.
public class AlertAction {
    
    // MARK: - Public Properties
    
    public enum Style {
        case primary
        case alternative
    }
    
    /// The title of the action’s button.
    public var title: String?
    
    /// The style that is applied to the action’s button.
    public var style: AlertAction.Style
    
    // MARK: - Internal Properties
    
    var handler: ((AlertAction) -> Void)?
    
    // MARK: - Initializer
    
    /// Create and return an action with the specified title and behavior.
    public init(title: String? = nil, style: AlertAction.Style = .primary, handler: ((AlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
}
