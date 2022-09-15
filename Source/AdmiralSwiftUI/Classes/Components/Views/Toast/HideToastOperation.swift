//
//  HideToastOperation.swift
//  AdmiralSwiftUI
//
//  Created on 04.08.2021.
//

import SwiftUI

@available(iOS 14.0, *)
final class HideToastOperation: Operation {

    // MARK: - Constants

    private enum Constants {
        static let hideAnimationDuration = 7.0
    }

    // MARK: - Internal Properties

    var timer = Timer()
    var currentCount: Double = 0
    var finishOperation: () -> Void
    var hideAnimationDuration: Double = Constants.hideAnimationDuration
    var cancelAnimationDuration: Double

    // MARK: - Initializer

    init(
        cancelAnimationDuration: Double = Constants.hideAnimationDuration,
        finishOperation: @escaping () -> Void
    ) {
        self.cancelAnimationDuration = cancelAnimationDuration
        self.finishOperation = finishOperation
    }

    // MARK: - Overriden Methods

    override func main() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { _ in
                guard !self.isCancelled else { return }

                self.currentCount += 0.1
                if self.currentCount == self.cancelAnimationDuration {
                    DispatchQueue.main.async {
                        self.finishOperation()
                    }
                }
            }
        )
    }
}
