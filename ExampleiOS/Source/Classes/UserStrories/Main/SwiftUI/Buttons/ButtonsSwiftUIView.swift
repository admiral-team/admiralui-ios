//
//  ButtonsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ButtonsSwiftUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Buttons") {
            scheme.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(ButtonsSwiftUIItem.allCases, id: \.self) { item in
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: self.$selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { self.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                                .accessibilityElement()
                                .accessibility(addTraits: .isButton)
                                .accessibility(identifier: item.title)
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
    func view(for type: ButtonsSwiftUIItem) -> some View {
        switch type {
        case .primaryButtons:
            PrimaryButtonsSwiftUIView()
        case .secondaryButtons:
            SecondaryButtonsSwiftUIView()
        case .ghostButtons:
            GhostButtonSwiftUIView()
        case .rules:
            RulesSwiftUIView()
        case .otherButtons:
            OtherButtonsSwiftUIView()

        }
    }
    
}
