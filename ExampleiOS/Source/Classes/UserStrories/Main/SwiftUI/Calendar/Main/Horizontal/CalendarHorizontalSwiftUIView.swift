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

    // MARK: - Private Properties

    @StateObject private var viewModel = CalendarHorizontalViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        return NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: .zero) {
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                CalendarView(
                    type: .horizontal,
                    startDate: viewModel.startDate,
                    endDate: viewModel.endDate,
                    selectedStartDate: $viewModel.selectedStartDate,
                    selectedEndDate: $viewModel.selectedEndDate,
                    monthYearDate: Date(),
                    notActiveAfterDate: Date(),
                    pointDates: [Date()]
                )
                Spacer()
            }
            .padding()
        }
        .onChange(of: viewModel.selectedStartDate, perform: { (_) in })
        .onChange(of: viewModel.selectedEndDate, perform: { (_) in })
    }
    
}
