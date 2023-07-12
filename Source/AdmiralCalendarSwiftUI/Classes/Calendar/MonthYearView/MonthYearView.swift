//
//  MonthYearView.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
struct MonthYearView: View {

    // MARK: - Internal Properties

    @State var title: String

    @ObservedObject private var schemeProvider: SchemeProvider<MonthYearViewScheme>
    
    // MARK: - Initializer

    init(
        title: String,
        schemeProvider: SchemeProvider<MonthYearViewScheme> = AppThemeSchemeProvider<MonthYearViewScheme>()
    ) {
        self._title = .init(initialValue: title)
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            schemeProvider.scheme.backgroundColor.swiftUIColor
            HStack {
                Text(title)
                    .font(schemeProvider.scheme.titleLabelFont.swiftUIFont)
                    .foregroundColor(schemeProvider.scheme.titleLabelColor.swiftUIColor)
                Spacer()
            }
        }

    }
}

@available(iOS 14.0, *)
struct MonthYearView_Previews: PreviewProvider {

    static var previews: some View {
        MonthYearView(title: "Май 2021")
            .previewLayout(PreviewLayout.sizeThatFits)
            .frame(height: 16.0)
            .padding()
            .environment(\.manager, SwiftUIThemeManager(theme: .light))
    }
}
