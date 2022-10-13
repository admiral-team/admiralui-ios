//
//  SliderTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 13.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InputNumberSwiftUIView: View {

    // MARK: - Private Properties

    @State private var selection: Int?
    @ObservedObject private var viewModel: InputNumberSwiftUIViewModel = .init()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Body

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                ForEach(viewModel.types, id: \.self) { type in
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    NavigationLink(
                        destination: view(for: type),
                        tag: type.rawValue,
                        selection: self.$selection
                    ) {
                        ListCell(
                            centerView: { TitleListView(title: type.description) },
                            trailingView: { ArrowListView() },
                            isHighlighted: Binding(get: { self.selection == type.rawValue }, set: { _ in }))
                        .frame(height: 68)
                    }
                    .onTapGesture {
                        withAnimation {
                            self.selection = type.rawValue
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
    }

    // MARK: - Layouts

    @ViewBuilder
    private func view(for type: InputNumberSwiftUIViewModel.InputNumberType) -> some View {
        switch type {
        case .secondary:
            SecondaryInputNumberView()
        case .default:
            InputNumberSwiftUIDefaultView()
        }
    }
}
