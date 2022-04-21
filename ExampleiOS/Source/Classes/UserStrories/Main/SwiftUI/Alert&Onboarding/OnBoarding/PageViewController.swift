//
//  PageViewController.swift
//  ExampleiOS
//
//  Created on 18.04.2022.
//
// swiftlint:disable all

import Foundation
import UIKit
import SwiftUI

@available(iOS 14.0.0, *)
struct PageViewController: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    @Binding var currentPageIndex: Int
    var viewControllers: [UIViewController]
    
    // MARK: - Internal Methods
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, pageIndex: currentPageIndex)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        pageViewController.setViewControllers(
            [viewControllers[currentPageIndex]], direction: .forward, animated: false)
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if context.coordinator.pageIndex < currentPageIndex {
            goToNextPage(pageController: pageViewController)
        }
    }
    
    private func goToNextPage(pageController: UIPageViewController) {
        guard let currentViewController = pageController.viewControllers?.first else { return }
        guard let nextViewController = pageController.dataSource?.pageViewController(
                pageController,
                viewControllerAfter: currentViewController ) else {
            return
        }
        
        pageController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        
        guard let index = viewControllers.firstIndex(of: nextViewController) else { return }
        currentPageIndex = index
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

        // MARK: - Properties
        
        var parent: PageViewController
        private(set) var pageIndex: Int

        // MARK: - Initializer
        
        init(_ pageViewController: PageViewController,
             pageIndex: Int) {
            self.parent = pageViewController
            self.pageIndex = pageIndex
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            // retrieves the index of the currently displayed view controller
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                 return nil
             }

            // show the view controller before the currently displayed view controller
            if index - 1 >= 0 {
                return parent.viewControllers[index - 1]
            }
            return nil

        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            // retrieves the index of the currently displayed view controller
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            // show the view controller after the currently displayed view controller
            if index + 1 < parent.viewControllers.count {
                return parent.viewControllers[index + 1]
            }
            return nil
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard let currentViewController = pageViewController.viewControllers?.first,
                  let index = parent.viewControllers.firstIndex(of: currentViewController) else { return }
            pageIndex = index
            parent.currentPageIndex = index
        }
        
    }

}
