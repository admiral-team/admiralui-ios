//
//  AdmiralGunEndpoint.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Foundation

enum AdmiralGunEndpoint: RequestBuilder {

    // MARK: - Url Requests

    case list(id: String)
    case allItems

    // MARK: - Private Properties

    private var defaultComponents: URLComponents {
        var components = URLComponents()
        components.path = path
        components.host = host.value
        components.scheme = scheme.rawValue
        switch self {
        case .allItems:
            components.port = 3000
        default:
            break
        }
        return components
    }

    private var path: String {
        switch self {
        case .list:
            return "/todos/"
        case .allItems:
            return "/api/allItems"
        }
    }

    private var scheme: URLScheme {
        switch self {
        case .list:
            return .https
        case .allItems:
            return .http
        }
    }

    private var host: URLHost {
        switch self {
        case .allItems, .list:
            return .localHost
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .list, .allItems:
            return .get
        }
    }

    private var headers: [String: String] {
        var httpHeaders = [String: String]()
        httpHeaders["Accept-Language"] = "ru_RU"
        httpHeaders["Content-Type"] = "application/json"
        return httpHeaders
    }

    private var components: URLComponents {
        switch self {
        case .list(let id):
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "id", value: id))
            var components = defaultComponents
            components.queryItems = queryItems
            return components
        case  .allItems:
            return defaultComponents
        }
    }

    // MARK: - Internal Properties

    func  asURLRequest() throws -> URLRequest {
        guard let url = components.url else {
            throw APIError.custom("Не получилось сформировать url")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 15
        request.httpMethod = method.rawValue
        switch self {
        case .list, .allItems:
            return request
        }
    }

}
