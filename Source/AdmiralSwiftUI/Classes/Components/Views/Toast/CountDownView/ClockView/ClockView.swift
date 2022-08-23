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

    @Binding private var scheme: ClockScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ClockScheme>()

    // MARK: - Initializer

    init(
        counter: Int,
        countTo: Int,
        scheme: Binding<ClockScheme?> = .constant(nil)
    ) {
        self.counter = counter
        self.countTo = countTo
        self._scheme = scheme
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
