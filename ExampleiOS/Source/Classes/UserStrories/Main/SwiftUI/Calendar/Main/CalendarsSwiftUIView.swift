//
//  CalendatsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 14.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CalendarsSwiftUIView: View {

    // MARK: - Type Alias

    typealias CalendarItems = CalendarsSwiftUIViewModel.CalendarsSwiftUIItem

    // MARK: - Environment

    @Environment(\.manager) var manager

    // MARK: - Private Properties

    @StateObject private var viewModel = CalendarsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(CalendarItems.allCases, id: \.self) { item in
                        // WORKAROUND: FOR NAVIGATION AFTER IOS 14.5
                        // https://developer.apple.com/forums/thread/677333
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: $viewModel.selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { viewModel.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                        }
                        .onTapGesture {
                            withAnimation {
                                viewModel.selection = item.rawValue
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func view(for type: CalendarItems) -> some View {
        switch type {
        case .vertical:
            CalendarSwiftUIView()
        case .horizontal:
            CalendarHorizontalSwiftUIView()
        }
    }
    
}
