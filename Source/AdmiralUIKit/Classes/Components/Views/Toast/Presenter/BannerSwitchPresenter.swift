//
//  BannerSwitchPresenter.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

/// Presenter with switch banner notification logic.
/// New banner view will replace current banner notification view.
public class BannerSwitchPresenter: BannerPresenterProtocol {
    
    // MARK: - Internal Properties
    
    var lastDispatchItem: DispatchWorkItem?
    var lastViewController = WeakBox<BannerWindowViewController>(value: nil)
    
    private var displayingTime: TimeInterval {
        return lastViewController.value?.config.displayingTime ?? 0.0
    }
    
    // MARK: - Private Properties
    
    private let queue = DispatchQueue(label: "com.banner.switch.presenter.queue")
    
    // MARK: - Initializer
    
    deinit {
        hideLastBanner()
        invalidateTimer()
    }
    
    // MARK: - Public Methods
    
    /// Show notification
    ///
    /// - Parameters:
    ///   - banner: View to present.
    ///   - config: Banner presentation configuration.
    public func show(banner: UIView, config: BannerNotification.Config) {
        hideLastBanner()
        
        let viewController = BannerWindowViewController(banner: banner, config: config)
        viewController.window?.makeKeyAndVisible()
        
        invalidateTimer()

        append(viewController: viewController)
        startTimer()
    }
    
    // MARK: - Private Properties
    
    private func startTimer() {
        invalidateTimer()
        
        let item = DispatchWorkItem(block: timerAction)
        lastDispatchItem = item
        
        queue.asyncAfter(deadline: .now() + displayingTime, execute: item)
    }
    
    private func timerAction() {
        hideLastBanner()
        removeLastViewController()
    }
    
    private func invalidateTimer() {
        lastDispatchItem?.cancel()
        lastDispatchItem = nil
    }
    
    private func append(viewController: BannerWindowViewController) {
        lastViewController.value?.delegate = nil
        lastViewController.value = viewController
    }
    
    private func removeLastViewController() {
        lastViewController.value?.delegate = nil
        lastViewController.value = nil
    }
    
    private func hideLastBanner() {
        lastViewController.value?.hideBanner()
    }
    
}

extension BannerSwitchPresenter: BannerWindowViewControllerDelegate {
    
    func startUserInteraction(viewController: BannerWindowViewController) {
        invalidateTimer()
    }
    
    func endUserInteraction(viewController: BannerWindowViewController) {
        removeLastViewController()
        
        if lastViewController.value != nil {
            startTimer()
        }
    }
    
}
