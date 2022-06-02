//
//  UnderlineTabsItem.swift
//  ExampleiOS
//
//  Created on 23.05.2022.
//

import SwiftUI

enum UnderlineTabsItem: Int, CaseIterable {
    case slider
    case center

    var title: String {
        switch self {
        case .slider:
            return "Slider"
        case .center:
            return "Center"
        }
    }
}
