//
//  BannerStackPresenter.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

/// Presenter with stack banner notification logic.
/// All banner view will be presented as stack and will disappear one by one.
public class BannerStackPresenter: BannerPresenterProtocol {
    
    // MARK: - Internal Properties
    
    var viewControllers = [WeakBox<BannerWindowViewController>]()
    
    var lastViewController: BannerWindowViewController? {
        return viewControllers.last?.value
    }
    
    // MARK: - Private Properties
    
    private var displayingTime: TimeInterval {
        return lastViewController?.config.displayingTime ?? 0.0
    }
    
    private let queue = DispatchQueue(label: "com.banner.stack.presenter.queue")
    private var lastDispatchItem: DispatchWorkItem?
    
    // MARK: - Initializer
    
    deinit {
        invalidateTimer()
        viewControllers.forEach { $0.value?.hideBanner() }
    }
    
    // MARK: - Public Methods
    
    /// Show notification
    ///
    /// - Parameters:
    ///   - banner: View to present.
    ///   - config: Banner presentation configuration.
    public func show(banner: UIView, config: BannerNotification.Config) {
        let viewController = BannerWindowViewController(banner: banner, config: config)
        viewController.window?.makeKeyAndVisible()
        
        append(viewController: viewController)
        startTimer()
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        invalidateTimer()
        
        let item = DispatchWorkItem(block: timerAction)
        lastDispatchItem = item
        
        queue.asyncAfter(deadline: .now() + displayingTime, execute: item)
    }
    
    private func timerAction() {
        if !viewControllers.isEmpty {
            hideLastBanner()
            removeLastViewController()
            startTimer()
        }
    }
    
    private func invalidateTimer() {
        lastDispatchItem?.cancel()
        lastDispatchItem = nil
    }
    
    private func append(viewController: BannerWindowViewController) {
        lastViewController?.delegate = nil
        
        viewController.delegate = self
        viewControllers.append(WeakBox(value: viewController))
    }
    
    private func removeLastViewController() {
        lastViewController?.delegate = nil
        
        viewControllers.removeLast()
    }
    
    private func hideLastBanner() {
        lastViewController?.hideBanner()
    }
    
}

extension BannerStackPresenter: BannerWindowViewControllerDelegate {

    func startUserInteraction(viewController: BannerWindowViewController) {
        invalidateTimer()
    }
    
    func endUserInteraction(viewController: BannerWindowViewController) {
        removeLastViewController()
        
        if !viewControllers.isEmpty {
            startTimer()
        }
    }
    
}
