//
//  InformersSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 18.05.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum InformersSwiftUIItem: Int, CaseIterable {
    case bigInformers
    case smallInformers
    
    var title: String {
        switch self {
        case .bigInformers:
            return "Big Informers"
        case .smallInformers:
            return "Small Informers"
        }
    }
}
