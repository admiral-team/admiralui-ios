//
//  TabsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 20.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TabsSwiftUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Tabs") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(TabsSwiftUIItem.allCases, id: \.self) { item in
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
    func view(for type: TabsSwiftUIItem) -> some View {
        switch type {
        case .standard:
            StandardTabSwiftUIView()
        case .underlineSlider:
            UnderlineSliderTabSwiftUIView()
        case .logo:
            LogoTabSwiftUIView()
        case .outlineSlider:
            OutlineSliderTabSwiftUITab()
        case .informer:
            InformerTabSwiftUIView()
        case .icon:
            IconTabsSwiftUI()
        }
    }
    
}
