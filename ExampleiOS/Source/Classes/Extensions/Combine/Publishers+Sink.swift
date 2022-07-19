//
//  Publishers+Sink.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Combine

@available(iOS 13.0.0, *)
extension Publisher {
    func sink(
        receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in },
        receiveValue: @escaping ((Self.Output) -> Void) = { _ in }
    ) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            guard case let .failure(error) = completion else {
                return
            }
            receiveFailure(error)
        }, receiveValue: { receiveValue($0) })
    }
}
