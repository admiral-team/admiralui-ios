//
//  StandardTextFieldsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 14.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct StandardTextFieldsSwiftUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Standard") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(StandardTextFieldsSwiftUIItem.allCases, id: \.self) { item in
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
    func view(for type: StandardTextFieldsSwiftUIItem) -> some View {
        switch type {
        case .standard:
            StandardTextFieldSwiftUIView()
        case .cardNumber:
            BankTextFieldSwiftUIView()
        case .smsCode:
            OTPTextFieldSwiftUIView()
        }
    }
    
}

@available(iOS 14.0.0, *)
struct StandardTextFieldsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StandardTextFieldsSwiftUIView()
    }
}
