//
//  CalendarSwiftUIView.swift
//  ExampleiOS
//
//  Created on 08.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CalendarSwiftUIView: View {
    
    @State var selectedStartDate: Date?
    @State var selectedEndDate: Date?
    
    // MARK: - Private Properties
    
    private var startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    private var endDate = Calendar.current.date(byAdding: .year, value: 100, to: Date()) ?? Date()
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Vertical") {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            CalendarView(
                type: .vertical,
                startDate: startDate,
                endDate: endDate,
                selectedStartDate: $selectedStartDate,
                selectedEndDate: $selectedEndDate,
                notActiveAfterDate: Date(),
                pointDates: [Date()]
            )
            .onChange(of: selectedStartDate, perform: { (_) in })
            .onChange(of: selectedEndDate, perform: { (_) in })
        }
    }
    
}
