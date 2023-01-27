//
//  ToastPresenter.swift
//  AdmiralSwiftUI
//
//  Created on 04.08.2021.
//

import SwiftUI
/**
 ToastPresenter - an object that controls a ToastView life cycle.
 You can create a ToastPresenter with the zero frame rectangle by specifying the following parameters in init:
 - animationDuration: Double: The full animation duration of ToastPresenter.
 - hideAnimationDuration: Double: The hide animation time of ToastPresenter.
 ## Example to create ToastPresenter
 # Code
 ```
 let presenter = ToastPresenter(
     animationDuration: animationDuration,
     hideAnimationDuration: hideAnimationDuration
 )
```
 */
@available(iOS 14.0.0, *)
public class ToastPresenter: ObservableObject {

    // MARK: - Constants

    public enum Constants {
        public static let hideAnimationDuration: Double = 5.0
    }

    // MARK: - Internal Properties

    @Published var toast: ToastView?
    @Published var toastNext: ToastView?

    @Published var animationDuration: Double = Durations.Default.double
    @Published var hideAnimationDuration: Double = Constants.hideAnimationDuration

    var isToastDisappear: Bool = true
    var isNextToastDisappear: Bool = true

    // MARK: - Private Properties

    private var timer: Timer?
    private var currentCount: Double = 0
    private let queue = OperationQueue()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    /// - Parameters:
    ///   - animationDuration: Animation duration.
    ///   - hideAnimationDuration: Cancel animation duration.
    public init(
        animationDuration: Double = Durations.Default.double,
        hideAnimationDuration: Double = Constants.hideAnimationDuration
    ) {
        self.animationDuration = animationDuration
        self.hideAnimationDuration = hideAnimationDuration

        queue.maxConcurrentOperationCount = 1
    }

    deinit {
        self.queue.cancelAllOperations()
        self.toast = nil
        self.toastNext = nil
    }

    // MARK: - Public Methods

    public func showView(
        _ view: ToastView,
        animationDuration: Double = Durations.Default.double,
        hideAnimationDuration: Double = Constants.hideAnimationDuration) {
        self.animationDuration = animationDuration
        self.hideAnimationDuration = hideAnimationDuration

        let showOperation = BlockOperation {
            let semaphore = DispatchSemaphore(value: 0)

            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self else {
                    semaphore.signal()
                    return
                }

                if !self.isToastDisappear {
                    self.toast = nil
                    self.toastNext = self.toastView(view, closeAction: { [weak self] in
                        self?.currentCount = 0
                        self?.timer?.invalidate()
                        self?.timer = nil
                        self?.toastNext = nil
                        self?.addHideOperation()
                    })
                } else {
                    self.toastNext = nil
                    self.toast = self.toastView(view, closeAction: { [weak self] in
                        self?.currentCount = 0
                        self?.timer?.invalidate()
                        self?.timer = nil
                        self?.toast = nil
                        self?.addHideOperation()
                    })
                }

                // WORKAROUND: Work for solve problem set pause.
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                    semaphore.signal()
                }
            }

            semaphore.wait()
        }

        addCancelOperation()
        queue.addOperation(showOperation)
    }

    // MARK: - Internal Methods

    func toastView(_ view: ToastView, closeAction: @escaping () -> ()) -> ToastView {
        if let timerDuration = view.timerDuration {
            return ToastView(
                title: view.title,
                linkText: view.linkText,
                linkAction: view.linkAction,
                timerDuration: timerDuration,
                closeAction: closeAction,
                closeView: view.closeView,
                type: view.type,
                accessibilityIdentifier: view.accessibilityIdentifier)
        } else {
            return ToastView(
                title: view.title,
                linkText: view.linkText,
                linkAction: view.linkAction,
                image: view.image,
                imageType: view.imageType,
                imageColorType: view.imageColorType,
                closeAction: closeAction,
                closeView: view.closeView,
                type: view.type,
                accessibilityIdentifier: view.accessibilityIdentifier)
        }
    }

    func cancelHideToast() {
        self.currentCount = 0
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = nil
            self.toast = nil
            self.toastNext = nil
        }
    }

    func addHideOperation() {
        let hideOperation = BlockOperation {
            let semaphore = DispatchSemaphore(value: 0)

            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self else {
                    semaphore.signal()
                    return
                }
                // WORKAROUND: Work for solve problem set pause.
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                    semaphore.signal()
                }
            }

            semaphore.wait()
        }
        queue.addOperation(hideOperation)
    }

    func addCancelOperation() {
        self.timer?.invalidate()
        self.timer = nil
        self.currentCount = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let `self` = self else { return }

            self.currentCount += 0.1
            if self.currentCount >= self.hideAnimationDuration {
                self.currentCount = 0
                self.timer?.invalidate()
                self.timer = nil
                self.toast = nil
                self.toastNext = nil
                self.addHideOperation()
            }
        })
    }


    func closeToasts() {
        self.toast = nil
        self.toastNext = nil
    }

}
