//
//  ThemeDisposable.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import Foundation

/// Disposable pattern
public class ThemeDisposable {
    
    private let disposal: () -> Void

    init(disposal: @escaping () -> Void) {
        self.disposal = disposal
    }

    deinit {
        self.disposal()
    }
    
}
