//
//  Publishers+Decode.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0.0, *)
extension Publisher {
    func decode<Output: Decodable>(
        to type: Output.Type,
        with jsonDecoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Output, Failure> where Self.Output == Data, Failure == APIError {
        flatMap { data -> AnyPublisher<Output, Failure> in
            do {
                return Just(try jsonDecoder.decode(Output.self, from: data))
                    .setFailureType(to: Failure.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: .custom("Response validation failed"))
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}
