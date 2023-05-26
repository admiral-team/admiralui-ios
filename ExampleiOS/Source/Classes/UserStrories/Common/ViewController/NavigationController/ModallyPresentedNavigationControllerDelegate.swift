//
//  BackButtonWithoutTitleNavigationControllerDelegate.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import AdmiralUIKit
import AdmiralImages
import UIKit

class BackButtonWithoutTitleNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        let backButton = UIBarButtonItem(
            title: "",
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil)
        
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
}

final class ModallyPresentedNavigationControllerDelegate: BackButtonWithoutTitleNavigationControllerDelegate {
    
    weak var modalNavigationController: UINavigationController?
            
    override func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        super.navigationController(navigationController, willShow: viewController, animated: animated)
        modalNavigationController = navigationController
 
        if viewController.isRootViewController
            && viewController.navigationItem.leftBarButtonItem == .none {
            setCloseButtonToViewController(viewController)
        }
    }
    
    fileprivate func setCloseButtonToViewController(_ viewController: UIViewController) {
        let closeButton = UIBarButtonItem(
            image: AdmiralImages.Asset.Service.Outline.closeCircleOutline.image,
            style: .plain,
            target: self,
            action: #selector(close))

        viewController.navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc fileprivate func close() {
        modalNavigationController?.dismiss(animated: true, completion: .none)
    }
    
}

private extension UIViewController {
    
    var isRootViewController: Bool {
        self == navigationController?.viewControllers.first
    }
    
}
