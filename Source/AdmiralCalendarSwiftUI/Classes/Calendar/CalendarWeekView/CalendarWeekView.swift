//
//  CalendarWeekView.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct CalendarWeekView: View {

    // MARK: - Private Properties

    private let dateFormatter = DateFormatter()
    private var weakDays: [String]

    @ObservedObject private var schemeProvider: SchemeProvider<CalendarWeekViewScheme>

    // MARK: - Initializer

    public init(
        _ locale: Locale? = nil,
        schemeProvider: SchemeProvider<CalendarWeekViewScheme> = AppThemeSchemeProvider<CalendarWeekViewScheme>()
    ) {
        self.weakDays = dateFormatter.getShortWeekdaySymbols(locale)
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        return HStack {
            ForEach(0..<weakDays.count, id: \.self) { index in
                Text(weakDays[index])
                    .frame(maxWidth: LayoutGrid.halfModule * 9, maxHeight: LayoutGrid.halfModule * 9)
                if index != 6 {
                    Spacer()
                }
            }
        }
        .font(scheme.titleLabelFont.swiftUIFont)
        .foregroundColor(scheme.titleLabelColor.swiftUIColor)
    }
}

@available(iOS 14.0, *)
struct CalendarWeekView_Previews: PreviewProvider {

    static var previews: some View {
        CalendarWeekView()
            .previewLayout(PreviewLayout.sizeThatFits)
            .frame(height: 16.0)
            .padding()

    }
}
