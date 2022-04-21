//
//  AppDelegate.swift
//  Example iOS
//
//  Created on 10.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol CustomWindowDelegate: AnyObject {
    @available(iOS 12.0, *)
    func userInterfaceStyleDidChange(_ window: UIWindow)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CustomWindowDelegate {
    
    var window: CustomWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Appearance.prepare()
        
        configureTheme()
        configureRootViewController()
        configureScrollBars()
        return true
    }
    
    private func configureTheme() {
        ThemesRepostory.default.initialConfiguration()
    }
    
    private func configureRootViewController() {
        let window = CustomWindow(frame: UIScreen.main.bounds)
        window.delegate = self
        self.window = window
        window.makeKeyAndVisible()
                
        let router = RootRouter()
        router.setRoot()
    }
    
    private func configureScrollBars() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    @available(iOS 12.0, *)
    func userInterfaceStyleDidChange(_ window: UIWindow) {
        guard UserDefaults.standard.bool(forKey: UserDefaults.Keys.isSystemChangeThemeOn) else { return }
        
        if window.traitCollection.userInterfaceStyle == .light {
            ThemesRepostory().apply(theme: .light)
        } else {
            ThemesRepostory().apply(theme: .dark)
        }
    }

}
