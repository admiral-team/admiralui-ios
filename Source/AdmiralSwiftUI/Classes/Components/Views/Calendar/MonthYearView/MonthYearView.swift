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
    @State private var scheme: MonthYearViewScheme? = nil
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<MonthYearViewScheme>()
    
    init(title: String) {
        self._title = .init(initialValue: title)
    }
    
    var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return ZStack {
            scheme.backgroundColor.swiftUIColor
            HStack {
                Text(title)
                    .font(scheme.titleLabelFont.swiftUIFont)
                    .foregroundColor(scheme.titleLabelColor.swiftUIColor)
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
