//
//  ControlParameter.swift
//  AdmiralUI
//
//  Created on 16.10.2020.
//

import AdmiralCore
import AdmiralTheme
import UIKit

typealias ControlParameter<P> = ParameterBox<UIControl.State,P>

extension UIControl.State: DefaultRepresentable {
    public static var defaultValue: UIControl.State { return .normal }
}
