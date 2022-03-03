//
//  CAPropertyAnimation+Extensions.swift
//  AdmiralUIResources
//
//  Created on 24.01.2022.
//

import UIKit

public extension CAPropertyAnimation {

    enum Key: String {
        var path: String {
            return rawValue
        }

        case strokeStart = "strokeStart"
        case strokeEnd = "strokeEnd"
        case strokeColor = "strokeColor"
        case rotationZ = "transform.rotation.z"
        case scale = "transform.scale"
    }

    convenience init(key: Key) {
        self.init(keyPath: key.path)
    }

}
