//
//  ThemeObserver.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import UIKit

class ThemeObserver {
    
    private let closure: (Theme) -> Void

    init(closure: @escaping (Theme) -> Void) {
        self.closure = closure
    }

    func handleThemeChange(on themeManager: ThemeManager) {
        assert(Thread.isMainThread)

        guard let theme = themeManager.theme else {
            var themeManager = themeManager
            Swift.withUnsafePointer(to: &themeManager) {
                NSLog("No theme found for theme manager \($0)")
            }
            return
        }
        themeManager.animated(duration: themeManager.animationDuration) {
            self.closure(theme)
        }
    }
    
}
