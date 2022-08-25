//
//  UnderlineTabsUIView.swift
//  ExampleiOS
//
//  Created on 23.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct UnderlineTabsUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "UnderlineTabs") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(UnderlineTabsItem.allCases, id: \.self) { item in
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: self.$selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { self.selection == item.rawValue }, set: { _ in }))
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
    func view(for type: UnderlineTabsItem) -> some View {
        switch type {
        case .slider:
            UnderlineSliderTabSwiftUIView()
        case .center:
            UnderlineCenterTabSwiftUIView()
        }
    }
}
