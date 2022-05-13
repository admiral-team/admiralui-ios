//
//  PinCodeTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class PinCodeTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var leftButtonTitle: String = "Не могу войти"
    @Published var rightButtonImage: Image = AdmiralUIResources.AssetSymbol.Security.Outline.faceID.image
    @Published var selectedNumber: String = ""
    @Published var controlsState: Int = 0
    @Published var maxCountNumbers: Double = 4
    @Published var status: CodeInputControl.Status = .normal

    // MARK: - Internal Properties

    var title: String {
        "Pincode"
    }

    var tabItems: [String] {
        ["Default", "Positive", "Error"]
    }

}
