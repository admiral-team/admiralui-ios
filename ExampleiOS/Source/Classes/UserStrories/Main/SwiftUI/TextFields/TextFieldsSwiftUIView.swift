//
//  TextFieldsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 13.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct TextFieldsSwiftUIView: View {

    // MARK: - Type Alias

    typealias TextFieldItem = TextFieldSwiftUIViewModel.TextFieldsSwiftUIItem

    // MARK: - Private Properties

    @StateObject private var viewModel = TextFieldSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(TextFieldItem.allCases, id: \.self) { item in
                        NavigationLink(
                            destination: view(for: item),
                            tag: item.rawValue,
                            selection: $viewModel.selection
                        ) {
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
    private func view(for type: TextFieldItem) -> some View {
        switch type {
        case .standard:
            StandardTextFieldsSwiftUIView()
        case .slider:
            InputRangeTextFieldSwiftUIView()
        case .number:
            InputNumberSwiftUIView()
        case .pincode:
            PinCodeTextFieldView()
        case .feedback:
            FeedbackInputSwiftUIView()
        case .double:
            DoubleTextFieldSwiftUIView()
        }
    }
    
}

@available(iOS 14.0.0, *)
struct TextFieldsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldsSwiftUIView()
    }
}
