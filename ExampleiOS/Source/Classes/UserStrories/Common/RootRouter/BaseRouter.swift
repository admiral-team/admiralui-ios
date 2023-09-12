//
//  BaseRouter.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import UIKit

typealias VoidClosure = () -> Void

class BaseRouter {
    
    /// View Controller
    weak var viewController: UIViewController?
    
    /// Router initializer
    ///
    /// - parameter viewController: see documentation
    ///
    /// - returns: router instance
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
}

// MARK: - Main router displaying view controller methods.

extension BaseRouter {
    
    static func setRootViewController(viewController: UIViewController,
                                      animated: Bool = false) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        
        window.rootViewController = viewController
        window.makeKey()
        if animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
        }
    }
    
    func setRootViewController(viewController: UIViewController,
                               animated: Bool = false) {
        BaseRouter.setRootViewController(viewController: viewController, animated: animated)
    }
    
    /// Push navigation
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func show(viewController: UIViewController) {
        
        guard let presenter = self.viewController else { return }
        
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Replace all view controllers in stack for new.
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func showOnly(viewController: UIViewController) {
        
        guard let presenter = self.viewController else { return }
        
        presenter.navigationController?.viewControllers = [viewController]
    }
    
    /// Modal navigation.
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func presentModally(viewController: UIViewController) {
        
        guard let presenter = self.viewController else { return }
        
        presenter.present(viewController, animated: true, completion: .none)
    }
    
    /// Dismiss modal presented view controller.
    func dismiss(animated: Bool = true) {
        viewController?.dismiss(animated: animated)
    }
    
    func dismissModalToRoot(animated: Bool = true) {
        UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController?.dismiss(animated: animated)
    }
    
    /// Dismiss view controller from navigation stack.
    func pop(animated: Bool = true) {
        if let nav = self.viewController as? UINavigationController {
            _ = nav.popViewController(animated: animated)
        } else {
            _ = self.viewController?.navigationController?.popViewController(animated: animated)
        }
    }
    
    /// Go to root view controller.
    func popToRoot(animated: Bool = true) {
        if let nav = self.viewController as? UINavigationController {
            _ = nav.popToRootViewController(animated: animated)
        } else {
            _ = self.viewController?.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    /// Open URL
    func openURL(_ url: URL?) {
        
        if let url = url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func call(phone: String) {
        let phone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    /// Dismiss modal presented view controller.
    func dismiss(animated: Bool = true, completion: VoidClosure? = nil) {
        viewController?.dismiss(animated: animated, completion: completion)
    }
    
}
