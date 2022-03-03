//
//  ToastNotificationsViewModel.swift
//  ExampleiOS
//
//  Created on 11.08.2021.
//

import SwiftUI
import AdmiralSwiftUI

@available(iOS 14.0, *)
struct ToastNotificationsViewModel {
    var typeToast: ToastNotificationsType = .toast
    var title: String
    var linkText: String?
    var imageType: ToastImageType
    var type: ToastViewType
    var timerDuration: Int?
    var closeView: (() -> (AnyView?))?
}

enum ToastNotificationsType {
    case toast
    case action
}
