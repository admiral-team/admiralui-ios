//
//  Array+ObservableObject.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import SwiftUI
import Combine

@available(iOS 14.0.0, *)
class ObservableArray<T>: ObservableObject {

    @Published var array: [T] = []

    init(array: [T]) {
        self.array = array
    }

}
