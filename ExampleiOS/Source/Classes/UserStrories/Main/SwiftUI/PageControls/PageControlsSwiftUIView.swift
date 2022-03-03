//
//  PageControlsUI.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct PageControlsSwiftUIView: View {

    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Page Controls") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(PageControlsSwiftUIItem.allCases, id: \.self) { item in
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
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
    func view(for type: PageControlsSwiftUIItem) -> some View {
        switch type {
        case .circular:
            CircularPageCOntrolSwiftUI()
        }
    }

}
