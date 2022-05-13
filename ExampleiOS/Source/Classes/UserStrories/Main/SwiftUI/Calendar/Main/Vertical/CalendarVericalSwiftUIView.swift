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

    // MARK: - Private Properties

    @StateObject private var viewModel = CalendarVerticalSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            CalendarView(
                type: .vertical,
                startDate: viewModel.startDate,
                endDate: viewModel.endDate,
                selectedStartDate: $viewModel.selectedStartDate,
                selectedEndDate: $viewModel.selectedEndDate,
                notActiveAfterDate: Date(),
                pointDates: [Date()]
            )
            .onChange(of: viewModel.selectedStartDate, perform: { (_) in })
            .onChange(of: viewModel.selectedEndDate, perform: { (_) in })
        }
    }
    
}
