//
//  CurrencySwiftUIViewItem.swift
//  ExampleiOS
//
//  Created on 02.08.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum CurrencySwiftUIViewItem: Int, CaseIterable {
    case `default`
    case icons
    case flags
    case iconsFlags
    
    var title: String {
        switch self {
        case .default:
            return "Default"
        case .icons:
            return "Icons"
        case .flags:
            return "Flags"
        case .iconsFlags:
            return "Icons & Flags"
        }
    }
}
