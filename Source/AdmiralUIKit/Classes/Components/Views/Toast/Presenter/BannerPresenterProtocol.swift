//
//  BannerPresenterProtocol.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

public protocol BannerPresenterProtocol {
    /// Show notification
    ///
    /// - Parameters:
    ///   - banner: View to present.
    ///   - config: Banner presentation configuration.
    func show(banner: UIView, config: BannerNotification.Config)
}


