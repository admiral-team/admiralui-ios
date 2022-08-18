//
//  ClockView.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 18.08.2022.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0, *)
struct Clock: View {

    // MARK: - Internal Properties

    var counter: Int
    var countTo: Int

    // MARK: - Private Properties

    @State private var scheme: ClockScheme? = nil
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ClockScheme>()

    // MARK: - Initializer

    init(
        counter: Int,
        countTo: Int,
        scheme: ClockScheme? = nil
    ) {
        self.counter = counter
        self.countTo = countTo
        self.scheme = scheme
    }

    // MARK: - Body

    var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack {
            Text(counterToMinutes())
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
        }
    }

    // MARK: - Internal Properties

    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60

        return "\(seconds)"
    }

}
