//
//  BannerNotification.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

/// Banner showing direction
public enum BannerNotificationDirection {
    /// From up
    case up
    /// From down
    case down
}

/// Base class to displaying local banner notifications.
public class BannerNotification: BannerPresenterProtocol {
    
    // MARK: - Internal Properties

    /// Banner notification presenter, that encapsulate all presentation logic.
    public let presenter: BannerPresenterProtocol
    
    // MARK: - Initializer
    
    /// - Parameter presenter: Banner notification presenter, that encapsulate all presentation logic.
    public init(presenter: BannerPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    
    /// Show banner.
    /// - Parameters:
    ///   - banner: banner view.
    ///   - config: configuration show banner.
    public func show(banner: UIView, config: Config) {
        presenter.show(banner: banner, config: config)
    }
    
    /// Presenter with stack banner notification logic.
    /// - Returns: object BannerStackPresenter
    public static func defaultStackBanner() -> BannerNotification {
        return BannerNotification(presenter: BannerStackPresenter())
    }
    
    /// Presenter with switch banner notification logic.
    /// - Returns: object BannerSwitchPresenter.
    public static func defaultSwitchBanner() -> BannerNotification {
        return BannerNotification(presenter: BannerSwitchPresenter())
    }
    
}

extension BannerNotification {
    
    /// Banner presentation configuration
    public struct Config {
        
        /// Banner insets.
        ///
        /// - safeArea: SafeArea mode will calculate insets automatic from view safe area.
        /// - absolute: Absolute mode will calculate manual insets from view absolute coordinate system.
        public enum Insets {
            case safeArea(offset: UIEdgeInsets)
            case absolute(insets: UIEdgeInsets)
        }
        
        /// Banner insets.
        public var insets: Insets
        
        /// Banner maximum width.
        public var maxWidth: CGFloat
        
        /// Banner minimum height.
        public var minHeight: CGFloat
        
        /// Banner displaying time. The time after which the banner will disappear
        public var displayingTime: TimeInterval
        
        /// Banner presenting animation duration.
        public var presentingDuration: TimeInterval
        
        /// Banner dismissing animation duration.
        public var dismissingDuration: TimeInterval
        
        /// Banner presenting from direction.
        public var direction: BannerNotificationDirection
        
        public init(insets: Insets,
                    maxWidth: CGFloat,
                    minHeight: CGFloat,
                    displayingTime: TimeInterval,
                    presentingDuration: TimeInterval,
                    dismissingDuration: TimeInterval,
                    direction: BannerNotificationDirection) {
            self.insets = insets
            self.maxWidth = maxWidth
            self.minHeight = minHeight
            
            self.displayingTime = displayingTime
            self.presentingDuration = presentingDuration
            self.dismissingDuration = dismissingDuration
            
            self.direction = direction
        }
        
        /// Default configuration.
        public static let `default` = Config(
            insets: .safeArea(offset: UIEdgeInsets(
                top: LayoutGrid.halfModule,
                left: LayoutGrid.module,
                bottom: LayoutGrid.doubleModule,
                right: LayoutGrid.module)),
            maxWidth: .infinity,
            minHeight: LayoutGrid.quadrupleModule,
            displayingTime: 7,
            presentingDuration: Durations.Default.single,
            dismissingDuration: Durations.Default.single,
            direction: .up)
        
    }
    
}

