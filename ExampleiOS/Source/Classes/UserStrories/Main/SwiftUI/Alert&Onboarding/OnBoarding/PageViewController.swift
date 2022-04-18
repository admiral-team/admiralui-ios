//
//  PageViewController.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 18.04.2022.
//
// swiftlint:disable all

import Foundation
import UIKit
import SwiftUI

@available(iOS 14.0.0, *)
struct PageViewController: UIViewControllerRepresentable {
    
    @Binding var currentPageIndex: Int
    
    var viewControllers: [UIViewController]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [viewControllers[currentPageIndex - 1]], direction: .forward, animated: true)
    }

}

@available(iOS 14.0.0, *)
class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var parent: PageViewController

    init(_ pageViewController: PageViewController) {
        self.parent = pageViewController
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // retrieves the index of the currently displayed view controller
        guard let index = parent.viewControllers.firstIndex(of: viewController) else {
             return nil
         }

        // show the view controller before the currently displayed view controller
        if index > 0 {
            return pageViewController.viewControllers?[index - 1]
        }
        return nil

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // retrieves the index of the currently displayed view controller
        guard let index = parent.viewControllers.firstIndex(of: viewController) else {
            return nil
        }

        // show the view controller after the currently displayed view controller
        if index < parent.viewControllers.count - 1 {
            return pageViewController.viewControllers?[index + 1]
        }
        return nil
    }
    
}
