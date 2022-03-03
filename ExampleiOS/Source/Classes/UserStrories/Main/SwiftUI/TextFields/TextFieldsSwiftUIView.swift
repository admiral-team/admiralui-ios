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
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Text Fields") {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(TextFieldsSwiftUIItem.allCases, id: \.self) { item in
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: self.$selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { return self.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.selection = item.rawValue
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func view(for type: TextFieldsSwiftUIItem) -> some View {
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
