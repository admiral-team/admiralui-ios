//
//  ToastNotificationsManager.swift
//  ExampleiOS
//
//  Created on 11.08.2021.
//

import Combine
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
final class ToastNotificationsManager: ObservableObject {

    static let `shared` = ToastNotificationsManager()
    @Published var model: ToastNotificationsViewModel?
    @Published var toastDirection: ToastNotificationsDirection?
    
    init() {}
}
