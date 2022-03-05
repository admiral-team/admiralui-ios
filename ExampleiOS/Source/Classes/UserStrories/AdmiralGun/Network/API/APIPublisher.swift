//
//  APISession.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Foundation
import Combine

@available(iOS 13.0, *)
struct APIPublisher<T: Decodable>: Publisher {

    // MARK: - Typealias

    typealias Output = T
    typealias Failure = APIError

    // MARK: - Properties

    private let dataPublisher: AnyPublisher<Output, Failure>

    // MARK: - Initializer

    init(builder: RequestBuilder, shouldPrintResponse: Bool = false) {
        guard let request = try? builder.asURLRequest() else {
            dataPublisher = Fail(error: .custom("Couldn't make request")).eraseToAnyPublisher()
            return
        }

        let decoder = JSONDecoder()
        dataPublisher = URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<Output, Failure> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: Output.self, decoder: decoder)
                            .mapError { _ in .decodingError }
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Publisher
    
    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        dataPublisher.receive(subscriber: subscriber)
    }

}
