//
//  CalendarHorizontalSwiftUIView.swift
//  ExampleiOS
//
//  Created on 13.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CalendarHorizontalSwiftUIView: View {
    
    // MARK: - Internal Properties
    
    @State var selectedStartDate: Date?
    @State var selectedEndDate: Date?
    
    // MAQRK: - Private Properties
    
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    var startDate: Date?
    var endDate: Date?
    
    init(selectedStartDate: Date?,
         selectedEndDate: Date?) {
        self._selectedStartDate = .init(initialValue: selectedStartDate)
        self._selectedEndDate = .init(initialValue: selectedEndDate)
    }

    public var body: some View {
        let scheme = schemeProvider.scheme
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        dateComponents.year = 2021
        dateComponents.month = 2
        
        return NavigationContentView(navigationTitle: "Horizontal") {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0.0) {
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                CalendarView(
                    type: .horizontal,
                    startDate: startDate,
                    endDate: endDate,
                    selectedStartDate: $selectedStartDate,
                    selectedEndDate: $selectedEndDate,
                    monthYearDate: Date(),
                    notActiveAfterDate: Date(),
                    pointDates: [Date()]
                )
                Spacer()
            }
            .padding()
        }
        .onChange(of: selectedStartDate, perform: { _ in })
        .onChange(of: selectedEndDate, perform: { _ in })
    }
    
}
