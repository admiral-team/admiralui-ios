//
//  ControlParameter.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import Foundation
import UIKit

// MARK: - Parameter Box

public struct ParameterBox<S,P> where S: RawRepresentable, S.RawValue: Hashable, S: DefaultRepresentable {

    private var parameters: [S.RawValue: P] = [:]

    public init() {
        //
    }

    public mutating func set(parameter: P?, for state: S) {
        self.parameters[state.rawValue] = parameter
    }

    public func parameter(for state: S) -> P? {
        if let result = parameters[state.rawValue] ?? parameters[S.defaultValue.rawValue] {
            return result
        } else {
            return nil
        }
    }

    public func forEachState(_ closure: ((S, P) -> Void)) {
        parameters.forEach() { closure(S(rawValue: $0.key) ?? S.defaultValue, $0.value) }
    }

}

public struct DoubleParameterBox<S1,S2,P>
where S1: RawRepresentable, S1.RawValue: Hashable, S1: DefaultRepresentable, S2: RawRepresentable, S2.RawValue: Hashable {

    private var parameters: [String: P?] = [:]

    public init() {
        //
    }

    public mutating func set(parameter: P?, for first: S1, state second: S2) {
        let key = paramKey(first: first, second: second)
        parameters[key] = parameter
    }

    public func parameter(for first: S1, state second: S2) -> P? {
        let key = paramKey(first: first, second: second)
        let defaultKey = paramKey(first: S1.defaultValue, second: second)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(first: S1, second: S2) -> String {
        return "\(first.rawValue).\(second.rawValue)"
    }

}

public protocol DefaultRepresentable {
    static var defaultValue: Self { get }
}
