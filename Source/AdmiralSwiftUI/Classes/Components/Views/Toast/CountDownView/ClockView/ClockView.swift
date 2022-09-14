//
//  ClockView.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0, *)
struct Clock: View {

    // MARK: - Internal Properties

    var counter: Int
    var countTo: Int

    // MARK: - Private Properties

    @ObservedObject var schemeProvider: SchemeProvider<ClockScheme>

    // MARK: - Initializer

    init(
        counter: Int,
        countTo: Int,
        schemeProvider: SchemeProvider<ClockScheme> = AppThemeSchemeProvider<ClockScheme>()
    ) {
        self.counter = counter
        self.countTo = countTo
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    var body: some View {
        let scheme = schemeProvider.scheme
        VStack {
            Text(counterToMinutes())
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
        }
    }

    // MARK: - Internal Methods

    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60

        return "\(seconds)"
    }

}
