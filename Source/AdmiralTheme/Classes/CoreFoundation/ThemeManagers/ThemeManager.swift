//
//  ThemeManager.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import UIKit


struct InvalidThemeError: Error {
    // intentionally left blank
}

struct RedundantObservationError: Error {
    // intentionally left blank
}

/// Theme manager for assigning a theme
final class ThemeManager {

    /// The default ThemeManager
    static let `default`: ThemeManager = .init()

    /// Whether to apply themes with animation
    var animated: Bool = true

    /// Duration of animation during theme application
    var animationDuration: TimeInterval = 0.3
    
    /// The current theme.
    ///
    /// - Important:
    /// Upon receiving an initial value any future values are expected to be of the same type.
    var theme: Theme? {
        willSet {
            #if DEBUG
            guard let currentValue = self.theme else {
                return
            }
            guard let newValue = newValue else {
                return
            }
            let currentThemeType = type(of: currentValue)
            let newThemeType = type(of: newValue)
            if currentThemeType != newThemeType {
                typealias ErrorType = InvalidThemeError
                let errorName = String(describing: ErrorType.self)
                let expected = String(describing: currentThemeType)
                let found = String(describing: newThemeType)
                print("\(self): Expected theme of type \(expected), found: \(found).")
                print("Info: Use a \"Swift Error Breakpoint\" on type \"\(errorName)\" to catch.")
                do {
                    throw ErrorType()
                } catch {
                    // intentionally left blank
                }
            }
            #endif
        }
        didSet {
            self.notify()
        }
    }
    
    // Notification used for broadcasting theme changes
    private static let notificationName = Notification.Name("AdmiralUI.ThemeChangedNotification")

    // NotificationCenter used for broadcasting theme changes
    private var notificationCenter: NotificationCenter = .init()
    
    // For appearance hack (see below), only accessible in iOS Applications
    private let optionalSharedApplication: UIApplication? = {
        let sharedSelector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: sharedSelector) else {
            // Extensions cannot access UIApplication
            return nil
        }
        let shared = UIApplication.perform(sharedSelector)
        return shared?.takeUnretainedValue() as? UIApplication
    }()
    
    private var observations: Set<ObjectIdentifier> = []

    /// Creates a `ThemeManager` instance
    ///
    /// - Note:
    ///   Consider using `ThemeManager.default` instead of creating your own instances.
    ///   It should cover 99% of your use-cases.
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDynamicTypeChange(_:)),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }

    /// Provides automated theme management for `themeable`.
    ///
    /// - Parameters:
    ///   - theme: `themeable`'s sub-theme's key-path relative to the Manager's current theme to apply
    ///   - themeable: the object to have the theme applied to
    func manage<T, U>(
        themeKeyPath keyPath: KeyPath<T, U.AssociatedTheme>,
        for themeable: U) where T: Theme, U: Themeable {
        let identifier = ObjectIdentifier(themeable)
        if observations.contains(identifier) {
            typealias ErrorType = RedundantObservationError
            let errorName = String(describing: ErrorType.self)
            let description = String(describing: themeable)
            print("\(self): Detected redundant observation of \(description).")
            print("Info: Use a \"Swift Error Breakpoint\" on type \"\(errorName)\" to catch.")
            do {
                throw ErrorType()
            } catch {
                // intentionally left blank
            }
        }
        observations.insert(identifier)

        let disposable = observe(theme: T.self, identifier: identifier) { [weak themeable] theme in
            guard let strongThemeable = themeable else {
                return
            }
            strongThemeable.apply(theme: theme[keyPath: keyPath])
        }

        var associatedObjectKey = ObjectIdentifier(ThemeManager.self)
        objc_setAssociatedObject(
            themeable,
            &associatedObjectKey,
            disposable,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
    
    /// Provides automated theme management for `themeable`.
    ///
    /// - Parameters:
    ///   - theme: `themeable`'s sub-theme's key-path relative to the Manager's current theme to apply
    ///   - themeable: the object to have the theme applied to
    func manage<T, U>(
        theme: T.Type,
        for themeable: U) where U: Themeable, U.AssociatedTheme == T {
        let identifier = ObjectIdentifier(themeable)
        if observations.contains(identifier) {
            typealias ErrorType = RedundantObservationError
            let errorName = String(describing: ErrorType.self)
            let description = String(describing: themeable)
            print("\(self): Detected redundant observation of \(description).")
            print("Info: Use a \"Swift Error Breakpoint\" on type \"\(errorName)\" to catch.")
            do {
                throw ErrorType()
            } catch {
                // intentionally left blank
            }
        }
        observations.insert(identifier)

        let disposable = observe(theme: T.self, identifier: identifier) { [weak themeable] theme in
            guard let strongThemeable = themeable else {
                return
            }
            strongThemeable.apply(theme: theme)
        }

        var associatedObjectKey = ObjectIdentifier(ThemeManager.self)
        objc_setAssociatedObject(
            themeable,
            &associatedObjectKey,
            disposable,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
    
    /// Provides automated theme notification via `closure`.
    ///
    /// - Parameters:
    ///   - theme: the theme to apply
    ///   - closure: closure for applying provided the theme to the sender
    ///
    /// - Important:
    ///   1. Within `closure` any access on "closed over" objects
    ///      must be guarded by `[weak ...]` to avoid retain cycles.
    ///   2. The body of `closure` should be [idempotent](https://en.wikipedia.org/wiki/Idempotence)
    ///      to avoid unwanted side-effects on repeated calls.
    public func observe<T>(
        theme: T.Type,
        closure: @escaping (T) -> Void) -> ThemeDisposable where T: Theme {
        observe(theme: theme, identifier: nil, closure: closure)
    }
    
    private func observe<T>(
        theme: T.Type,
        identifier: ObjectIdentifier?,
        closure: @escaping (T) -> Void) -> ThemeDisposable where T: Theme {
        #if DEBUG
        if let currentTheme = self.theme, type(of: currentTheme) != theme {
            typealias ErrorType = InvalidThemeError
            let errorName = String(describing: ErrorType.self)
            let expected = String(describing: type(of: currentTheme))
            let found = String(describing: theme)
            print("\(self): Expected observation of type \(expected), found: \(found).")
            print("Info: Use a \"Swift Error Breakpoint\" on type \"\(errorName)\" to catch.")
            do {
                throw ErrorType()
            } catch {
                // intentionally left blank
            }
        }
        #endif

        let observer = ThemeObserver { theme in
            guard let theme = theme as? T else {
                return
            }
            closure(theme)
        }

        let notificationObject = add(observer: observer)

        if let theme = self.theme as? T {
            closure(theme)
        }

        // Strongly references the observer (required):
        return ThemeDisposable { [weak self, observer] in
            guard let self = self else { return }
            self.remove(notificationObject: notificationObject, observer: observer)
            
            if let identifier = identifier {
                self.observations.remove(identifier)
            }
        }
    }

    private func add(observer: ThemeObserver) -> NSObjectProtocol {
        let notificationObject = notificationCenter.addObserver(
            forName: ThemeManager.notificationName,
            object: self,
            queue: OperationQueue.main) { [weak observer] notification in
            guard
                let themeManager = notification.object as? ThemeManager
            else {
                return
            }
            observer?.handleThemeChange(on: themeManager)
        }
        
        return notificationObject
    }

    private func remove(notificationObject: NSObjectProtocol, observer: ThemeObserver) {
        notificationCenter.removeObserver(
            notificationObject,
            name: ThemeManager.notificationName,
            object: nil
        )
    }

    private func notify() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.notificationCenter.post(
                name: ThemeManager.notificationName,
                object: self
            )

            if let sharedApplication = self.optionalSharedApplication {
                for window in sharedApplication.windows {
                    for view in window.subviews {
                        // Fix keyboard calculating. UIInputSetContainerView
                        let viewType = "VUlJbnB1dFNldENvbnRhaW5lclZpZXc=".base64Decoded()
                        if type(of: view).description() != viewType {
                            view.removeFromSuperview()
                            window.addSubview(view)
                        }
                    }
                }
            }
        }
    }

    func animated(duration: TimeInterval, closure: @escaping () -> Void) {
        UIView.animate(withDuration: duration) {
            closure()
        }
    }

    @objc private func handleDynamicTypeChange(_ notification: Notification) {
        notify()
    }
    
}

extension ThemeManager: CustomStringConvertible {
    
    public var description: String {
        var mutableSelf = self
        return Swift.withUnsafePointer(to: &mutableSelf) { pointer in
            let name = String(describing: type(of: self))
            let address = String(format: "%p", pointer)
            return "<\(name): \(address)>"
        }
    }
    
}

private extension String {

    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

}
