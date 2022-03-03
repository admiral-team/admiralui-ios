//
//  Keyboard.swift
//  ExampleiOS
//
//  Created on 19.02.2021.
//

import AdmiralUIKit
import UIKit

// MARK: - Keyboard Binding

struct KeyboardInfo {
    let frame: CGRect
    let bottomOffset: CGFloat
    let curve: UIView.AnimationOptions
    let duration: TimeInterval
}

protocol KeyboardBindable: AnyObject {
    var rootBindableView: UIView { get }
    func keyboardFrameWillChangeFrame(info: KeyboardInfo)
    func keyboardFrameWillShow(info: KeyboardInfo)
    func keyboardFrameWillHide(info: KeyboardInfo)
}

extension KeyboardBindable {
    func keyboardFrameWillChangeFrame(info: KeyboardInfo) {}
    func keyboardFrameWillShow(info: KeyboardInfo) {}
    func keyboardFrameWillHide(info: KeyboardInfo) {}
}

extension KeyboardBindable where Self: UIViewController {
    var rootBindableView: UIView { return view }
}

extension KeyboardBindable where Self: UIView {
    var rootBindableView: UIView { return self }
}

final class KeyboardBinder: NSObject {
    
    weak var bindable: KeyboardBindable?
    
    func bindToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillChangeFrame),
            name: UIWindow.keyboardWillChangeFrameNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIWindow.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIWindow.keyboardWillHideNotification,
            object: nil)
    }
    
    func unbindFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIWindow.keyboardWillChangeFrameNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIWindow.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIWindow.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard let info = keyboardInfo(from: notification) else { return }
        bindable?.keyboardFrameWillChangeFrame(info: info)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let info = self.keyboardInfo(from: notification) else { return }
        bindable?.keyboardFrameWillShow(info: info)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let info = self.keyboardInfo(from: notification) else { return }
        bindable?.keyboardFrameWillHide(info: info)
    }
    
    private func keyboardInfo(from notification: Notification) -> KeyboardInfo? {
        guard
            let bindable = bindable,
            let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let curveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let durationValue = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        else {
            return nil
        }
        
        let duration = TimeInterval(durationValue.doubleValue)
        let curve = UIView.AnimationOptions(rawValue: curveValue.uintValue)
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        let rootViewFrame = bindable.rootBindableView.convert(bindable.rootBindableView.bounds, to: nil)
        let bottomOffset = max(rootViewFrame.maxY - keyboardFrame.minY, 0)
        
        return KeyboardInfo(frame: keyboardFrame, bottomOffset: bottomOffset, curve: curve, duration: duration)
    }
    
}
