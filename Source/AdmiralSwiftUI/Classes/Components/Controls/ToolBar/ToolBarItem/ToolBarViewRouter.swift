//
//  ToolBarViewRouter.swift
//  AdmiralSwiftUI
//
//  Created on 01.06.2021.
//

import Foundation

@available(iOS 14.0.0, *)
final class ToolBarViewRouter: ObservableObject {
    @Published var currentPage: Int = 0
}
