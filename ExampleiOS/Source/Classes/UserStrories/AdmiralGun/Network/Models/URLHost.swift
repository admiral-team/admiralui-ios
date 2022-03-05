//
//  URLHost.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Foundation

enum URLHost {
    case localHost

    var value: String {
        switch self {
        case .localHost:
            return "127.0.0.1"
        }
    }
}
