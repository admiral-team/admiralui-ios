//
//  Publishers+Extensions.swift
//  ExampleiOS
//
//  Created on 25.01.2022.
//

import Combine

@available(iOS 14.0.0, *)
extension Publisher where Self.Output: OptionalType {

    func filterNil() -> AnyPublisher<Self.Output.Wrapped, Self.Failure> {
        return flatMap { element -> AnyPublisher<Self.Output.Wrapped, Self.Failure> in
            guard let value = element.value else {
                return Empty(completeImmediately: false)
                    .setFailureType(to: Self.Failure.self)
                    .eraseToAnyPublisher()
            }
            return Just(value)
                .setFailureType(to: Self.Failure.self)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

}

@available(iOS 14.0.0, *)
protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

@available(iOS 14.0.0, *)
extension Optional: OptionalType {
    public var value: Wrapped? { self }
}
