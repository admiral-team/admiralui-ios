//
//  ControlParameter.swift
//  AdmiralUIResources
//
//  Created on 30.06.2021.
//

import SwiftUI
import AdmiralTheme

// MARK: - Control State
/**
 ControlState - Public enum for TitleListView
 
 ControlState can be one of the following values:
 - normal
 - highlighted
 - disabled
 - selected
 */
public enum ControlState: UInt {
    case normal
    case highlighted
    case disabled
    case selected
}

extension ControlState: DefaultRepresentable {
    public static var defaultValue: ControlState { return ControlState.normal }
}

public typealias ControlParameter<P> = ParameterBox<ControlState,P>
