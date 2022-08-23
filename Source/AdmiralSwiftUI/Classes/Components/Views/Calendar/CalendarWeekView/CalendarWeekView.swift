//
//  CalendarWeekView.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
struct CalendarWeekView: View {

    // MARK: - Private Properties

    private let dateFormatter = DateFormatter()
    private var weakDays: [String]

    @Binding private var scheme: CalendarWeekViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CalendarWeekViewScheme>()

    // MARK: - Initializer

    init(
        _ locale: Locale? = nil,
        scheme: Binding<CalendarWeekViewScheme?> = .constant(nil)
    ) {
        self.weakDays = dateFormatter.getShortWeekdaySymbols(locale)
        self._scheme = scheme
    }

    // MARK: - Body

    var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return HStack {
            ForEach(0..<weakDays.count, id: \.self) { index in
                Group {
                    Text(weakDays[index])
                        .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                    if index != 6 {
                        Spacer()
                    }
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
